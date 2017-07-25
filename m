From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 25 Jul 2017 09:35:55 +0000
Subject: Re: [PATCH v4] video/console: Add dmi quirk table for x86 systems which need fbcon rotation
Message-Id: <20170725113555.39e22df7@endymion>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170723103239.26019-1-hdegoede@redhat.com>
In-Reply-To: <20170723103239.26019-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sun, 23 Jul 2017 12:32:39 +0200, Hans de Goede wrote:
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
> ---
> Changes in v2:
> -Extend the commit message explaining why dmi_check_system does not work
>  and this commit exports and uses dmi_matches instead
> 
> Changes in v3:
> -The exporting of dmi_matches has been split out in a separate patch
> -Use u32 for width/height in struct fbcon_dmi_rotate_data to match the
>  type of fb_var_screeninfo.xres / .yres
> 
> Changes in v4:
> -Use dmi_first_match instead of exporting dmi_matches
> -Use DMI_EXACT_MATCH
> -Add the Asus T100HA to the list of devices needing rotation
> ---
>  drivers/video/console/Makefile           |   3 +
>  drivers/video/console/fbcon.c            |  12 ++-
>  drivers/video/console/fbcon.h            |   7 +-
>  drivers/video/console/fbcon_dmi_quirks.c | 130 +++++++++++++++++++++++++++++++
>  4 files changed, 148 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/video/console/fbcon_dmi_quirks.c
> (...)

Looks good to me.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
