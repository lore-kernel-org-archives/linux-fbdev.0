From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 19 May 2010 19:08:18 +0000
Subject: Re: viafb suspend & resume, v2
Message-Id: <4BF43722.4060601@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272813454-3229-1-git-send-email-FlorianSchandinat@gmx.de> <20100510195636.7936ec76@neptune.home>
In-Reply-To: <20100510195636.7936ec76@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, corbet@lwn.net

Bruno Pr=E9mont schrieb:
> On Sun, 02 May 2010 Florian Tobias Schandinat <FlorianSchandinat@gmx.de> =
wrote:
>> This is the second version of this patch series. It is forward ported to=
 apply
>> on Jon's current viafb-posted branch. Furthermore the engine is only
>> (re)started if the mmio space is mapped.
>> There are still issues left especially device configuration and it does =
not yet
>> integrate nicely in the new structure of the driver. However it is in a =
state
>> where it shouldn't hurt anyone but could be useful for some people.
>=20
> Only works with restrictions on my box.

Thanks for testing it.

> If I have accel enabled system freezes during suspend, if accel is disabl=
ed
> system suspends&resumes.
>>From a quick glance at the code I don't know what to do to disable accel
> during suspend (and restore it on resume)...

I am wondering where the freeze comes from. We don't use too much of the en=
gine
and we already wait for it to become idle. Can you please test whether this=
 patch
fixes it? It's not really acceleration related but other framebuffers do th=
e same
and maybe it has a side effect for acceleration.

> viafb is not able to get GPU alive from its own, it still needs to have t=
he
> BIOS run VBIOS on resume.

Okay, I guess the current code needs to be cleaned up before I can expect i=
t to
work reliable...


Thanks,

Florian Tobias Schandinat

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index f581fb7..10b907a 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1750,6 +1750,7 @@ int viafb_suspend(struct pci_dev *pdev, pm_message_t =
state)
  		fb_set_suspend(viafbinfo, 1);

  		viafb_sync(viafbinfo);
+		viafb_blank(FB_BLANK_POWERDOWN, viafbinfo);

  		pci_save_state(pdev);
  		pci_disable_device(pdev);
