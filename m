From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Wed, 02 Aug 2017 11:26:13 +0000
Subject: Re: [PATCH] fbdev: matrox: hide unused 'hotplug' variable
Message-Id: <ba8a1b02-913c-0873-9a98-7569080fd66d@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170802093722.3666961-1-arnd@arndb.de>
 <20170802100124.bcr3ux6bt4hnlu6r@phenom.ffwll.local>
In-Reply-To: <20170802100124.bcr3ux6bt4hnlu6r@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, Sean Paul <seanpaul@chromium.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Arnd,

With is change we can get below error. If MODULE is define.

drivers/video/fbdev/matrox/matroxfb_base.c: In function =91initMatrox2=92:
drivers/video/fbdev/matrox/matroxfb_base.c:1799:23: error: =91hotplug=92=20
undeclared (first use in this function)
   minfo->fbcon.flags =3D hotplug ? FBINFO_FLAG_MODULE : FBINFO_FLAG_DEFAUL=
T;

Please check this.

~arvind


On Wednesday 02 August 2017 03:31 PM, Daniel Vetter wrote:
> On Wed, Aug 02, 2017 at 11:36:47AM +0200, Arnd Bergmann wrote:
>> The variable has become unused in modular configurations
>> which triggers a harmless warning:
>>
>> drivers/video/fbdev/matrox/matroxfb_base.c:1583:12: error: 'hotplug' def=
ined but not used [-Werror=3Dunused-variable]
>>
>> This moves it into an #ifdef section of the file, matching
>> all its references.
>>
>> Fixes: 376b3ff54c9a ("fbdev: Nuke FBINFO_MODULE")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
>> ---
>>   drivers/video/fbdev/matrox/matroxfb_base.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/=
fbdev/matrox/matroxfb_base.c
>> index fd1589fcdf15..00ea4e4ab95a 100644
>> --- a/drivers/video/fbdev/matrox/matroxfb_base.c
>> +++ b/drivers/video/fbdev/matrox/matroxfb_base.c
>> @@ -1578,9 +1578,9 @@ static struct fb_videomode defaultmode =3D {
>>   	NULL, 60, 640, 480, 39721, 40, 24, 32, 11, 96, 2,
>>   	0, FB_VMODE_NONINTERLACED
>>   };
>> -#endif /* !MODULE */
>>  =20
>>   static int hotplug =3D 0;
>> +#endif /* !MODULE */
>>  =20
>>   static void setDefaultOutputs(struct matrox_fb_info *minfo)
>>   {
>> --=20
>> 2.9.0
>>

