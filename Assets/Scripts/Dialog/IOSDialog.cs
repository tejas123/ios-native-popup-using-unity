using UnityEngine;
using System.Collections;

public class IOSDialog : MonoBehaviour
{

    #region DELEGATE

    public delegate void OnDialogPopupComplete(MessageState state);

    public static event OnDialogPopupComplete onDialogPopupComplete;

    #endregion

    #region DELEGATE_CALLS

    private void RaiseOnOnDialogPopupComplete(MessageState state)
    {
        if (onDialogPopupComplete != null)
            onDialogPopupComplete(state);
    }

    #endregion

    #region PUBLIC_VARIABLES

    public string title;
    public string message;
    public string yes;
    public string no;
    public string urlString;

    #endregion

    #region PUBLIC_FUNCTIONS

    // Constructor
    public static IOSDialog Create(string title, string message)
    {
        return Create(title, message, "Yes", "No");
    }

    public static IOSDialog Create(string title, string message, string yes, string no)
    {
        IOSDialog dialog;
        dialog = new GameObject("IOSDialogPopUp").AddComponent<IOSDialog>();
        dialog.title = title;
        dialog.message = message;
        dialog.yes = yes;
        dialog.no = no;
        dialog.init();
        return dialog;
    }

    public void init()
    {
        IOSNative.showDialog(title, message, yes, no);
    }

    #endregion

    #region IOS_EVENT_LISTENER

    public void OnDialogPopUpCallBack(string buttonIndex)
    {
        int index = System.Convert.ToInt16(buttonIndex);
		
        switch (index)
        {
            case 0: 
                IOSNative.RedirectToWebPage(urlString);
                RaiseOnOnDialogPopupComplete(MessageState.YES);
                break;
            case 1: 
                RaiseOnOnDialogPopupComplete(MessageState.NO);
                break;
        }
        Destroy(gameObject);
    }

    #endregion
}
