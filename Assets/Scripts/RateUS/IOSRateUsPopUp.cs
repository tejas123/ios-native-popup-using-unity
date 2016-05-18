using UnityEngine;
using System.Collections;

public class IOSRateUsPopUp : MonoBehaviour
{
    #region DELEGATE

    public delegate void OnRateUSPopupComplete(MessageState state);

    public static event OnRateUSPopupComplete onRateUSPopupComplete;

    #endregion

    #region DELEGATE_CALLS

    private void RaiseOnOnRateUSPopupComplete(MessageState state)
    {
        if (onRateUSPopupComplete != null)
            onRateUSPopupComplete(state);
    }

    #endregion

    #region PUBLIC_VARIABLES

    public string title;
    public string message;
    public string rate;
    public string remind;
    public string declined;
    public string appleId;

    #endregion

    #region PUBLIC_FUNCTIONS

    public static IOSRateUsPopUp Create()
    {
        return Create("Like the Game?", "Rate US");
    }

    public static IOSRateUsPopUp Create(string title, string message)
    {
        return Create(title, message, "Rate Now", "Ask me later", "No, thanks");
    }

    public static IOSRateUsPopUp Create(string title, string message, string rate, string remind, string declined)
    {
        IOSRateUsPopUp popup = new GameObject("IOSRateUsPopUp").AddComponent<IOSRateUsPopUp>();
        popup.title = title;
        popup.message = message;
        popup.rate = rate;
        popup.remind = remind;
        popup.declined = declined;
		
        popup.init();
        return popup;
    }

    public void init()
    {
        IOSNative.showRateUsPopUP(title, message, rate, remind, declined);
    }

    #endregion

    #region IOS_EVENT_LISTENER

    public void OnRatePopUpCallBack(string buttonIndex)
    {
        int index = System.Convert.ToInt16(buttonIndex);
        switch (index)
        {
            case 0: 
                IOSNative.RedirectToAppStoreRatingPage(appleId);
                RaiseOnOnRateUSPopupComplete(MessageState.RATED);
                break;
            case 1:
                RaiseOnOnRateUSPopupComplete(MessageState.REMIND);
                break;
            case 2:
                RaiseOnOnRateUSPopupComplete(MessageState.DECLINED);
                break;
        }
        Destroy(gameObject);
    }

    #endregion
}
