using UnityEngine;
using System.Collections;

public class NativeRateUS
{

    #region PUBLIC_VARIABLES

    public string title;
    public string message;
    public string yes;
    public string later;
    public string no;
    public string appleId;

    #endregion

    #region PUBLIC_FUNCTIONS

    // Constructor
    public NativeRateUS(string title, string message)
    {
        this.title = title;
        this.message = message;
        this.yes = "Rate app";
        this.later = "Later";
        this.no = "No, thanks";
    }

    // Constructor
    public NativeRateUS(string title, string message, string yes, string later, string no)
    {
        this.title = title;
        this.message = message;
        this.yes = yes;
        this.later = later;
        this.no = no;
    }
    // Set AppID to rate app
    public void SetAppleId(string _appleId)
    {
        appleId = _appleId;
    }
	
    // Initialize rate popup
    public void InitRateUS()
    {
        #if UNITY_IPHONE
        IOSRateUsPopUp rate = IOSRateUsPopUp.Create(title, message, yes, later, no);
        rate.appleId = appleId;
        #endif
    }

    #endregion
}
