From: John Stanley <jpsinthemix@verizon.net>
Date: Fri, 29 Jul 2011 12:20:32 +0000
Subject: Re: [Bugme-new] [Bug 39842] New: savagefb.h CARD SERIES definition
Message-Id: <4E32A590.5040504@verizon.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070407070906010607000608"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110728162752.3a4602e4.akpm@linux-foundation.org>
In-Reply-To: <20110728162752.3a4602e4.akpm@linux-foundation.org>
To: linux-fbdev@vger.kernel.org

This is a multi-part message in MIME format.
--------------070407070906010607000608
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Replying to all.. I have also attached the one-line patch.
thanks,
John

On 07/28/2011 07:27 PM, Andrew Morton wrote:
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
>
> On Sat, 23 Jul 2011 10:20:41 GMT
> bugzilla-daemon@bugzilla.kernel.org wrote:
>
>> https://bugzilla.kernel.org/show_bug.cgi?id=39842
>>
>>             Summary: savagefb.h CARD SERIES definition typo
>>             Product: Drivers
>>             Version: 2.5
>>      Kernel Version: 3.0.0
>>            Platform: All
>>          OS/Version: Linux
>>                Tree: Mainline
>>              Status: NEW
>>            Severity: normal
>>            Priority: P1
>>           Component: Video(Other)
>>          AssignedTo: drivers_video-other@kernel-bugs.osdl.org
>>          ReportedBy: jpsinthemix@verizon.net
>>          Regression: Yes
>>
>>
>> I have an old T22 Thinkpad with integrated Savage/IX-MV video. As of linux-3.0,
>> the video is non-functional; the PC either hard hangs immediately or has
>> totally garbled video, and then hard hangs, as soon as I attempt to edit a file
>> or cat a file with more than a screen-full of text. The foregoing details are
>> actually not important any more as in looking at the code changes I discovered
>> a typo in linux-3.0.0/drivers/video/savage/savagefb.h and have applied the
>> following patch to fix the issue:
>>
>> --- linux-3.0.0.old/drivers/video/savage/savagefb.h     2011-07-21
>> 22:17:23.000000000 -0400
>> +++ linux-3.0.0.new/drivers/video/savage/savagefb.h     2011-07-23
>> 05:13:33.801215293 -0400
>> @@ -55,7 +55,7 @@
>>
>>   #define S3_SAVAGE3D_SERIES(chip)  ((chip>=S3_SAVAGE3D)&&
>> (chip<=S3_SAVAGE_MX))
>>
>> -#define S3_SAVAGE4_SERIES(chip)   ((chip>=S3_SAVAGE4) ||
>> (chip<=S3_PROSAVAGEDDR))
>> +#define S3_SAVAGE4_SERIES(chip)   ((chip>=S3_SAVAGE4)&&
>> (chip<=S3_PROSAVAGEDDR))
>>
>>   #define S3_SAVAGE_MOBILE_SERIES(chip)  ((chip==S3_SAVAGE_MX) ||
>> (chip==S3_SUPERSAVAGE))
>>
>>
>> P.S. Many, many thanks for lifting the 800x600 resolution limit! I've been
>> using a patch/hack to bump the limit to 1024x768 for an very long time...
>> John
> Please resend that fix as a formal signed-off-patch as a reply-to-all
> to this email?  Documentation/SubmittingPatches has some tips.
>
> Thanks.
>
>


--------------070407070906010607000608
Content-Type: text/plain;
 name="01-linux-3.0.0-savagefb-card-series-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="01-linux-3.0.0-savagefb-card-series-fix.patch"

--- linux-3.0.0.old/drivers/video/savage/savagefb.h	2011-07-21 22:17:23.000000000 -0400
+++ linux-3.0.0.new/drivers/video/savage/savagefb.h	2011-07-23 05:13:33.801215293 -0400
@@ -55,7 +55,7 @@
 
 #define S3_SAVAGE3D_SERIES(chip)  ((chip>=S3_SAVAGE3D) && (chip<=S3_SAVAGE_MX))
 
-#define S3_SAVAGE4_SERIES(chip)   ((chip>=S3_SAVAGE4) || (chip<=S3_PROSAVAGEDDR))
+#define S3_SAVAGE4_SERIES(chip)   ((chip>=S3_SAVAGE4) && (chip<=S3_PROSAVAGEDDR))
 
 #define S3_SAVAGE_MOBILE_SERIES(chip)  ((chip==S3_SAVAGE_MX) || (chip==S3_SUPERSAVAGE))
 


--------------070407070906010607000608--
