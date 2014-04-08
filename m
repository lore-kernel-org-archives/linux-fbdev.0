From: Christopher Freeman <cfreeman@nvidia.com>
Date: Tue, 08 Apr 2014 21:43:56 +0000
Subject: Re: [PATCH] video: Check EDID for HDMI connection
Message-Id: <CF69BB5D.3C9E7%cfreeman@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395873337-41305-1-git-send-email-cfreeman@nvidia.com>
In-Reply-To: <1395873337-41305-1-git-send-email-cfreeman@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



On 4/8/14 2:19 AM, "Tomi Valkeinen" <tomi.valkeinen@ti.com> wrote:

>* PGP Signed by an unknown key
>
>Hi,
>
>On 27/03/14 00:35, cfreeman@nvidia.com wrote:
>> From: David Ung <davidu@nvidia.com>
>> 
>> Check EDID Vendor Specific Data Block bytes to see if the connection
>> is HDMI and set FB_MISC_HDMI.
>> 
>> Signed-off-by: David Ung <davidu@nvidia.com>
>> Signed-off-by: Christopher Freeman<cfreeman@nvidia.com>
>> ---
>
>Patch looks fine, but how do you use the flag? Shouldn't things like
>detecting if the monitor supports audio be done with some more detailed
>bits in the EDID data (not that I remember much from the HDMI spec).
The Tegra HDMI driver uses FB_MISC_HDMI to select the type of connection
it has hdmi/dvi and setup the avi info frames.
agree that we could use the EDID data to determine the audio format
support and sampling rates, but currently that's not being used.
I think determining the audio format and sample rate support could be
added in a separate and future patch.



>
> Tomi
>
>
>
>* Unknown Key
>* 0xBC961EF5

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
