From: John Stanley <jpsinthemix@verizon.net>
Date: Tue, 02 Aug 2011 03:19:18 +0000
Subject: [PATCH] Fix typo in savage4 series definition in linux-3.0.0
Message-Id: <4E376CB6.4000803@verizon.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070908050107000900050500"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

This is a multi-part message in MIME format.
--------------070908050107000900050500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Tormod,

Attached is the same patch, but with your 'Reviewed-by' added.

Yeah, the T22 is rather old, and a bit of a 'Frankenstein PC' at this 
point, but its quite functional even with Linux-3.0 and KDE-4.7

thanks again,
John

On 08/01/2011 06:56 PM, Tormod Volden wrote:
> On Sun, Jul 31, 2011 at 12:04 PM, John Stanley wrote:
>>   I have an old T22 Thinkpad with integrated Savage/IX-MV video. As of
>> linux-3.0, the video is non-functional; the PC either hard hangs immediately
>> or has totally garbled video, and then hard hangs, as soon as I attempt to
>> edit a file or cat a file with more than a screen-full of text. The
>> foregoing details are actually not important any more as in looking at the
>> code changes I discovered a typo in
>> linux-3.0.0/drivers/video/savage/savagefb.h and have applied the attached
>> patch to fix the issue.
> John, you are absolutely correct. My bad, this was from a commit of
> mine. You may add my
>   Reviewed-by: Tormod Volden<debian.tormod@gmail.com>
> to your patch. I'd suggest you change the patch description (mail
> subject) to "[PATCH] Fix typo in savage4 series definition" or
> something similar.
>
> The patch should also go into the stable series (by cc'ing
> stable@vger.kernel.org if I remember correctly).
>
>> PLEASE NOTE:
>>   I realize that the patch does not quite adhere to linux kernel patch
>> coding-style conventions (in particular, spaces around logical operators,
>> and lines not exceeding 80 chars), but I have simply changed an
>> '||' to an'&&' -- and NOT attempted to resolve pre-existing coding-style
>> violations.
> I also preserved the old coding style, which is the same in the xorg
> driver which shares much of this code. We can always change it there
> as well if somebody would like to fix it up.
>
>> thanks much,
>> John
>>
>> P.S. Many, many thanks for lifting the 800x600 resolution limit! I've been
>> using a patch/hack to bump the limit to 1024x768 for an very long time...
> Glad to hear that! So there are still other savagefb users around :)
> My apologies to those who were affected by the typo.
>
> Cheers,
> Tormod
>

--------------070908050107000900050500
Content-Type: text/plain;
 name="linux-3.0.0-savagefb-savage4-series-def-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-3.0.0-savagefb-savage4-series-def-fix.patch"

This patch corrects a typo/regression in the savage driver code occurring in going
from linux-2.6.39.3 to linux-3.0.0.

In linux-2.6.39.3, there were two savage4 variants (S3_SAVAGE4 and S3_PROSAVAGE).
Hence, S3_SAVAGE4_SERIES was defined as

  S3_SAVAGE4 or S3_PROSAVAGE

In linux-3.0.0, two additional savage4 variants (S3_TWISTER and S3_PROSAVAGEDDR) have
been added. Hence S3_SAVAGE4_SERIES should be defined as

  S3_SAVAGE4, S3_PROSAVAGE, S3_TWISTER, or S3_PROSAVAGEDDR

In going from linux-2.6.39.3 to linux-3.0.0, the define statement for S3_SAVAGE4_SERIES
was incompletely modified: the '||' should have been changed to an '&&'; for an '||' will
set S3_SAVAGE4_SERIES true for any card.

Signed-off-by: John P. Stanley <jpsinthemix@verizon.net>

Reviewed-by: Tormod Volden <debian.tormod@gmail.com>

--- linux-3.0.0/drivers/video/savage/savagefb.h.orig	2011-07-21 22:17:23.000000000 -0400
+++ linux-3.0.0/drivers/video/savage/savagefb.h	2011-07-31 05:27:47.314798215 -0400
@@ -55,7 +55,7 @@
 
 #define S3_SAVAGE3D_SERIES(chip)  ((chip>=S3_SAVAGE3D) && (chip<=S3_SAVAGE_MX))
 
-#define S3_SAVAGE4_SERIES(chip)   ((chip>=S3_SAVAGE4) || (chip<=S3_PROSAVAGEDDR))
+#define S3_SAVAGE4_SERIES(chip)   ((chip>=S3_SAVAGE4) && (chip<=S3_PROSAVAGEDDR))
 
 #define S3_SAVAGE_MOBILE_SERIES(chip)  ((chip==S3_SAVAGE_MX) || (chip==S3_SUPERSAVAGE))
 

--------------070908050107000900050500--
