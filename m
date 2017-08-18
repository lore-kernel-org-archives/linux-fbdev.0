From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 18 Aug 2017 17:22:30 +0000
Subject: Re: [PATCH v6] video/console: Add dmi quirk table for x86 systems which need fbcon rotation
Message-Id: <1946235.rVRVXPVoPu@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sunday, July 30, 2017 07:59:19 AM Hans de Goede wrote:
> Some x86 clamshell design devices use portrait tablet screens and a
> display engine which cannot rotate in hardware, so we need to rotate
> the fbcon to compensate.
> 
> This commit adds a DMI based quirk table which is initially populated with
> 4 such devices: The Asus T100HA, GPD Pocket, the GPD win and the I.T.Works
> TW891, so that the console comes up in the right orientation on these
> devices OOTB.
> 
> Unfortunately these (cheap) devices also typically have quite generic DMI
> data, so we match on a combination of DMI data, screen resolution and a
> list of known BIOS dates to avoid false positives.
> 
> Suggested-by: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

