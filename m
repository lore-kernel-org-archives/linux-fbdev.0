From: Jiri Kosina <jkosina@suse.cz>
Date: Wed, 15 Aug 2012 08:15:29 +0000
Subject: Re: [PATCH 6/7] HID: picoLCD: disable version check during probe
Message-Id: <alpine.LNX.2.00.1208151015220.7026@pobox.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120730213656.0a9f6d30@neptune.home> <20120730213859.063173c1@neptune.home>
In-Reply-To: <20120730213859.063173c1@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, 30 Jul 2012, Bruno Prémont wrote:

> Commit 4ea5454203d991ec85264f64f89ca8855fce69b0
> [HID: Fix race condition between driver core and ll-driver] introduced
> new locking around proce/remove functions that prevent any report/reply
> from hardware to reach driver until it returned from probe.
> 
> As such, the ask-reply way to checking picoLCD firmware version during
> probe is bound to timeout and let probe fail.
> 
> Disabling the check lets driver sucessfully probe again.
> 
> Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
> ---
>  drivers/hid/hid-picolcd_core.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
> index 2d7ef68..42d0791 100644
> --- a/drivers/hid/hid-picolcd_core.c
> +++ b/drivers/hid/hid-picolcd_core.c
> @@ -478,13 +478,13 @@ static int picolcd_probe_lcd(struct hid_device *hdev, struct picolcd_data *data)
>  {
>  	int error;
>  
> -	error = picolcd_check_version(hdev);
> +/*	error = picolcd_check_version(hdev);
>  	if (error)
>  		return error;
>  
>  	if (data->version[0] != 0 && data->version[1] != 3)
>  		hid_info(hdev, "Device with untested firmware revision, please submit /sys/kernel/debug/hid/%s/rdesc for this device.\n",
> -			 dev_name(&hdev->dev));
> +			 dev_name(&hdev->dev)); */

Please just remove it altogether, I don't see a reason to keep the 
commented-out code in the in-tree driver.

Once the locking mess is sorted out, we can re-introduce it again as 
necessary.

Thanks.

-- 
Jiri Kosina
SUSE Labs
