From: Peter Jones <pjones@redhat.com>
Date: Wed, 25 Aug 2010 17:24:01 +0000
Subject: Re: [PATCH] Add new linearfb driver
Message-Id: <4C7551B1.3000703@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100825141111.GI21862@riva.ucam.org> <20100825190438.55ecb34d@neptune.home>
In-Reply-To: <20100825190438.55ecb34d@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?QnJ1bm8gUHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Cc: Colin Watson <cjwatson@canonical.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg@redhat.com>

On 08/25/2010 01:04 PM, Bruno Pr=C3=A9mont wrote:
> On Wed, 25 August 2010 Colin Watson <cjwatson@canonical.com> wrote:
>> Split out linearfb from efifb so that boot loaders can program it as a
>> simple linear framebuffer on non-EFI systems.  This is useful for boot
>> loaders with their own graphics drivers, e.g. GRUB 2, since in some
>> cases on x86 they can set up non-VESA modes and thus can't program
>> vesafb.
>>
>> efifb is reworked on top of this common code, and it should be possible
>> to do the same with some other framebuffer drivers in future.
>>
>> Signed-off-by: Colin Watson <cjwatson@canonical.com>
>> Acked-by: Matthew Garrett <mjg@redhat.com>
>> Cc: Peter Jones <pjones@redhat.com>
>> ---
>>  drivers/video/Kconfig       |   17 ++-
>>  drivers/video/Makefile      |    1 +
>>  drivers/video/efifb.c       |  222 +----------------------------
>>  drivers/video/linearfb.c    |  332 ++++++++++++++++++++++++++++++++++++=
+++++++
>>  include/linux/fb.h          |    8 +
>>  include/linux/screen_info.h |    2 +
>>  6 files changed, 364 insertions(+), 218 deletions(-)
>>  create mode 100644 drivers/video/linearfb.c
>>
>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>> index 59c51d9..a7735ec 100644
>> --- a/drivers/video/Kconfig
>> +++ b/drivers/video/Kconfig
>> @@ -721,13 +721,24 @@ config FB_VESA
>>  	  You will get a boot time penguin logo at no additional cost. Please
>>  	  read <file:Documentation/fb/vesafb.txt>. If unsure, say Y.
>> =20
>> -config FB_EFI
>> -	bool "EFI-based Framebuffer Support"
>> -	depends on (FB =3D y) && X86 && EFI
>> +config FB_LINEAR
>> +	bool "Simple linear framebuffer support"
>> +	depends on FB
>>  	select FB_CFB_FILLRECT
>>  	select FB_CFB_COPYAREA
>>  	select FB_CFB_IMAGEBLIT
>         ^^^^^^^^^^^^^^^^^^^^^^^
>=20
>>  	help
>> +	  This is a simple linear frame buffer device driver. It has no
>> +	  hardware-specific programming capability, but must be programmed
>> +	  by the boot loader or by another frame buffer driver.
>> +
>> +	  If unsure, say N.
>> +
>> +config FB_EFI
>> +	bool "EFI-based Framebuffer Support"
>> +	depends on (FB =3D y) && X86 && EFI
>> +	select FB_LINEAR
>         ^^^^^^^^^^^^^^^^
>   Has kconfig been adjusted to process select recursively?
>   If not the selects from FB_LINEAR will have to be copied here.

This could also be solved by just making it depend on FB_LINEAR instead of
using "select".

--=20
        Peter

I number the Linux folks among my personal heroes.
		-- Donald Knuth

012345678901234567890123456789012345678901234567890123456789012345678901234=
56789
