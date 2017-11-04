From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 04 Nov 2017 13:13:21 +0000
Subject: Re: [Intel-gfx] [PATCH v3 6/7] efifb: Set info->fbcon_rotate_hint based on drm_get_panel_orientation
Message-Id: <e3845905-ded6-1b2c-c38c-bd6d2b6ee4ee@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171023071425.5090-1-hdegoede@redhat.com>
 <20171023071425.5090-7-hdegoede@redhat.com>
 <20171030095345.663btb7tq2qpnzys@phenom.ffwll.local>
In-Reply-To: <20171030095345.663btb7tq2qpnzys@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Vetter <daniel@ffwll.ch>, Hans de Goede <j.w.r.degoede@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, intel-gfx <intel-gfx@lists.freedesktop.org>, Daniel Drake <drake@endlessm.com>, dri-devel@lists.freedesktop.org, Bastien Nocera <hadess@hadess.net>, Daniel Vetter <daniel.vetter@intel.com>

Hi,

On 30-10-17 10:53, Daniel Vetter wrote:
> On Mon, Oct 23, 2017 at 09:14:24AM +0200, Hans de Goede wrote:
>> On some hardware the LCD panel is not mounted upright in the casing,
>> but rotated by 90 degrees. In this case we want the console to
>> automatically be rotated to compensate.
>>
>> The drm subsys has a quirk table for this, use the
>> drm_get_panel_orientation_quirk function to get the panel orientation
>> and set info->fbcon_rotate_hint based on this, so that the fbcon console
>> on top of efifb gets automatically=C2=A0rotated to compensate for the pa=
nel
>> orientation.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/video/fbdev/Kconfig |  1 +
>>   drivers/video/fbdev/efifb.c | 21 ++++++++++++++++++++-
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
>> index 5e58f5ec0a28..c4a90c497839 100644
>> --- a/drivers/video/fbdev/Kconfig
>> +++ b/drivers/video/fbdev/Kconfig
>> @@ -772,6 +772,7 @@ config FB_VESA
>>   config FB_EFI
>>   	bool "EFI-based Framebuffer Support"
>>   	depends on (FB =3D y) && !IA64 && EFI
>> +	select DRM_PANEL_ORIENTATION_QUIRKS
>>   	select FB_CFB_FILLRECT
>>   	select FB_CFB_COPYAREA
>>   	select FB_CFB_IMAGEBLIT
>> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
>> index 3a010641f630..8c7f6aeee205 100644
>> --- a/drivers/video/fbdev/efifb.c
>> +++ b/drivers/video/fbdev/efifb.c
>> @@ -15,6 +15,8 @@
>>   #include <linux/screen_info.h>
>>   #include <video/vga.h>
>>   #include <asm/efi.h>
>> +#include <drm/drm_utils.h> /* For drm_get_panel_orientation_quirk */
>> +#include <drm/drm_mode.h>  /* For DRM_MODE_PANEL_ORIENTATION_* */
>>  =20
>>   static bool request_mem_succeeded =3D false;
>>   static bool nowc =3D false;
>> @@ -156,7 +158,7 @@ static u64 bar_offset;
>>   static int efifb_probe(struct platform_device *dev)
>>   {
>>   	struct fb_info *info;
>> -	int err;
>> +	int err, orientation;
>>   	unsigned int size_vmode;
>>   	unsigned int size_remap;
>>   	unsigned int size_total;
>> @@ -328,6 +330,23 @@ static int efifb_probe(struct platform_device *dev)
>>   	info->fix =3D efifb_fix;
>>   	info->flags =3D FBINFO_FLAG_DEFAULT | FBINFO_MISC_FIRMWARE;
>>  =20
>> +	orientation =3D drm_get_panel_orientation_quirk(efifb_defined.xres,
>> +						      efifb_defined.yres);
>=20
> Oh right, that's the reason for the separate function. Still ugh.
>=20
> Maybe add a comment in the kernel-doc for why it is what it is ...

Actually the drm_get_panel_orientation_quirk() function was missing
a kernel-doc comment documenting it altogether. For v5 of this
patch-set I've added a kernel-doc comment and I've added this bit
to that kernel-doc comment to explain why drm_get_panel_orientation_quirk()
lives in a separate .ko target:

  * Note this function is also used outside of the drm-subsys, by for examp=
le
  * the efifb code. Because of this this function gets compiled into its own
  * kernel-module when built as a module.

Regards,

Hans



> -Daniel
>=20
>> +	switch (orientation) {
>> +	default:
>> +		info->fbcon_rotate_hint =3D FB_ROTATE_UR;
>> +		break;
>> +	case DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP:
>> +		info->fbcon_rotate_hint =3D FB_ROTATE_UD;
>> +		break;
>> +	case DRM_MODE_PANEL_ORIENTATION_LEFT_UP:
>> +		info->fbcon_rotate_hint =3D FB_ROTATE_CCW;
>> +		break;
>> +	case DRM_MODE_PANEL_ORIENTATION_RIGHT_UP:
>> +		info->fbcon_rotate_hint =3D FB_ROTATE_CW;
>> +		break;
>> +	}
>> +
>>   	err =3D sysfs_create_groups(&dev->dev.kobj, efifb_groups);
>>   	if (err) {
>>   		pr_err("efifb: cannot add sysfs attrs\n");
>> --=20
>> 2.14.2
>>
>> _______________________________________________
>> Intel-gfx mailing list
>> Intel-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
>=20
