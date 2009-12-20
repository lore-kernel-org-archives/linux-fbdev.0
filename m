From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Date: Sun, 20 Dec 2009 21:10:47 +0000
Subject: Re: drivers/gpu/drm/radeon/radeon_test.c:45: undefined reference to
Message-Id: <alpine.LNX.2.01.0912201209250.9200@filesrv1.baby-dragons.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="566704117-281555746-1261343454=:9200"
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LNX.2.01.0912181147200.9874@filesrv1.baby-dragons.com> <21d7e9970912192211y6cb02557se261787f3b56d2a8@mail.gmail.com>
In-Reply-To: <21d7e9970912192211y6cb02557se261787f3b56d2a8@mail.gmail.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev@vger.kernel.org, Linux Kernel Maillist <linux-kernel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--566704117-281555746-1261343454=:9200
Content-Type: TEXT/PLAIN; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

 	Hello Dave ,

On Sun, 20 Dec 2009, Dave Airlie wrote:
> On Sat, Dec 19, 2009 at 6:54 AM, Mr. James W. Laferriere
> <babydr@baby-dragons.com> wrote:
>> =A0 =A0 =A0 =A0Hello Benjamin , =A0I am not having a good time compiling=
 2.6.32.1 .
>> First RCU 'inline' difficulties then fusion-mpt 'inline' difficulty , =
=A0Now
>> this .
>> =A0 =A0 =A0 =A0This one is not a simple as removing 'inline' from a stat=
ement .
>> =A0 =A0 =A0 =A0Would you please look into this ? =A0Anything else you ne=
ed please just
>> ask .
>> =A0 =A0 =A0 =A0Please cc: me as I am not subscribed to linux-fbdev .
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Tia , =A0JimL
>>
>
> Can you try the attached patch?
>
> Dave.

 	With the below DRM items configured .  The patch allows me to complete=20
the compilation of linux ...

# grep -i drm .config
CONFIG_DRM=3Dy
CONFIG_DRM_KMS_HELPER=3Dy
CONFIG_DRM_TTM=3Dy
CONFIG_DRM_TDFX=3Dy
CONFIG_DRM_R128=3Dy
CONFIG_DRM_RADEON=3Dy
CONFIG_DRM_I810=3Dy
# CONFIG_DRM_I830 is not set
CONFIG_DRM_I915=3Dy
# CONFIG_DRM_I915_KMS is not set
CONFIG_DRM_MGA=3Dy
CONFIG_DRM_SIS=3Dy
CONFIG_DRM_VIA=3Dy
CONFIG_DRM_SAVAGE=3Dy

# dir -alrt arch/x86/boot/bzImage
6336 -rw-r--r-- 1 root root 6475472 2009-12-20 21:01 arch/x86/boot/bzImage


 		Hth ,  JimL
--=20
+------------------------------------------------------------------+
| James   W.   Laferriere | System    Techniques | Give me VMS     |
| Network&System Engineer | 3237     Holden Road |  Give me Linux  |
| babydr@baby-dragons.com | Fairbanks, AK. 99709 |   only  on  AXP |
+------------------------------------------------------------------+
--566704117-281555746-1261343454=:9200--
