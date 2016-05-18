using UnityEngine;
using System.Collections;

public class IOSMessage : MonoBehaviour
{
    #region DELEGATE

    public delegate void OnMessagePopupComplete(MessageState state);

    public static event OnMessagePopupComplete onMessagePopupComplete;

    #endregion

    #region DELEGATE_CALLS

    private void RaiseOnMessagePopupComplete(MessageState state)
    {
        if (onMessagePopupComplete != null)
            onMessagePopupComplete(state);
    }

    #endregion

    #region PUBLIC_VARIABLES

    public string title;
    public string message;
    public string ok;

    #endregion

    #region PUBLIC_FUNCTIONS

    public static IOSMessage Create(string title, string message)
    {
        return Create(title, message, "Ok");
    }

    public static IOSMessage Create(string title, string message, string ok)
    {
        IOSMessage dialog;
        dialog = new GameObject("IOSMessagePopUp").AddComponent<IOSMessage>();
        dialog.title = title;
        dialog.message = message;
        dialog.ok = ok;
		
        dialog.init();
        return dialog;
    }

    public void init()
    {
        IOSNative.showMessage(title, message, ok);
    }

    #endregion

    #region IOS_EVENT_LISTENER

    public void OnPopUpCallBack(string buttonIndex)
    {
        RaiseOnMessagePopupComplete(MessageState.OK);
        Destroy(gameObject);
    }

    #endregion
}
