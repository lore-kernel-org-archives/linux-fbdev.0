From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 02 Jan 2019 17:52:23 +0000
Subject: Re: [PATCH] drm/nouveau: fix incorrect FB_BACKLIGHT usage in Kconfig
Message-Id: <a66ec947-0856-c459-da68-09639bfef22a@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20181228151521eucas1p163e845ef691ac2bd78051e6fa4c068d0@eucas1p1.samsung.com>
 <6f25a4a3-3d24-e811-7c0b-bbdd8ff8aa8b@samsung.com>
 <66054836-bc70-900e-0171-086ef2239e62@infradead.org>
In-Reply-To: <66054836-bc70-900e-0171-086ef2239e62@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>


On 12/28/2018 07:03 PM, Randy Dunlap wrote:
> On 12/28/18 7:15 AM, Bartlomiej Zolnierkiewicz wrote:
>> Making FB_BACKLIGHT tristate by commit b4a1ed0cd18b ("fbdev:
>> make FB_BACKLIGHT a tristate") caused unmet dependencies in
>> some configurations:
>>
>> WARNING: unmet direct dependencies detected for FB_BACKLIGHT
>>   Depends on [m]: HAS_IOMEM [=y] && FB [=m]
>>   Selected by [y]:
>>   - DRM_NOUVEAU [=y] && HAS_IOMEM [=y] && DRM [=y] && PCI [=y] && MMU [=y] && DRM_NOUVEAU_BACKLIGHT [=y]
>>   Selected by [m]:
>>   - FB_NVIDIA [=m] && HAS_IOMEM [=y] && FB [=m] && PCI [=y] && FB_NVIDIA_BACKLIGHT [=y]
>>
>> Fix it by making DRM_NOUVEAU select BACKLIGHT_CLASS_DEVICE and
>> BACKLIGHT_LCD_SUPPORT instead of FB_BACKLIGHT.
>>
>> Fixes: b4a1ed0cd18b ("fbdev: make FB_BACKLIGHT a tristate")
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Rob Clark <robdclark@gmail.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Ben Skeggs <bskeggs@redhat.com>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Works for me.  Thanks.
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks, I queued the patch for 4.21.

>> ---
>> I would like to merge this patch through fbdev tree for v4.21
>> (as it is needed to fix commit currently in fbdev tree).
>>
>>  drivers/gpu/drm/nouveau/Kconfig |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> Index: b/drivers/gpu/drm/nouveau/Kconfig
>> =================================>> --- a/drivers/gpu/drm/nouveau/Kconfig	2018-11-30 11:46:55.716464505 +0100
>> +++ b/drivers/gpu/drm/nouveau/Kconfig	2018-12-28 14:54:51.655965845 +0100
>> @@ -4,7 +4,8 @@ config DRM_NOUVEAU
>>          select FW_LOADER
>>  	select DRM_KMS_HELPER
>>  	select DRM_TTM
>> -	select FB_BACKLIGHT if DRM_NOUVEAU_BACKLIGHT
>> +	select BACKLIGHT_CLASS_DEVICE if DRM_NOUVEAU_BACKLIGHT
>> +	select BACKLIGHT_LCD_SUPPORT if DRM_NOUVEAU_BACKLIGHT
>>  	select ACPI_VIDEO if ACPI && X86 && BACKLIGHT_CLASS_DEVICE && INPUT
>>  	select X86_PLATFORM_DEVICES if ACPI && X86
>>  	select ACPI_WMI if ACPI && X86

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
