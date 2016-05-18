using UnityEngine;
using System.Collections;

public class NativeDialog
{
    #region PUBLIC_VARIABLES

    string title;
    string message;
    string yesButton;
    string noButton;


    public string urlString;

    #endregion

    #region PUBLIC_FUNCTIONS

    public NativeDialog(string title, string message)
    {
        this.title = title;
        this.message = message;
        this.yesButton = "Yes";
        this.noButton = "No";
    }

    public NativeDialog(string title, string message, string yesButtonText, string noButtonText)
    {
        this.title = title;
        this.message = message;
        this.yesButton = yesButtonText;
        this.noButton = noButtonText;
    }

    public void SetUrlString(string urlString)
    {
        this.urlString = urlString;
    }

    public void init()
    {
        #if UNITY_IPHONE
        IOSDialog dialog = IOSDialog.Create(title, message, yesButton, noButton);
        dialog.urlString = urlString;
        #endif
    }

    #endregion
}
