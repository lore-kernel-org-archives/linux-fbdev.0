From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 04 Sep 2017 13:30:45 +0000
Subject: Re: [PATCH] vgacon: Prevent faulty bootparams.screeninfo from causing harm
Message-Id: <4081598.xEOLvXfVEx@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Sunday, August 27, 2017 08:23:29 PM Jan H. Sch=F6nherr wrote:
> If a zero for the number of colums or rows manages to slip through,
> gotoxy() will underflow vc->vc_pos, causing the next action on the
> referenced memory to end with a page fault.
>=20
> Make the check in vgacon_startup() more pessimistic to prevent that.
>=20
> Signed-off-by: Jan H. Sch=F6nherr <jschoenh@amazon.de>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

