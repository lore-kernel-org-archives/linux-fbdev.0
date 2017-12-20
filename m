From: Johannes Thumshirn <jthumshirn@suse.de>
Date: Wed, 20 Dec 2017 12:48:31 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <20171220124831.hrqnozdcnwbssy37@linux-x5ow.site>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
 <20171220110809.u7bf6miyiorio6bz@linux-x5ow.site>
 <CAPj87rPvfvYP8WsUuQ4rq58-2qbqCkDztowAMUW7oJa6Bw1TnQ@mail.gmail.com>
In-Reply-To: <CAPj87rPvfvYP8WsUuQ4rq58-2qbqCkDztowAMUW7oJa6Bw1TnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Stone <daniel@fooishbar.org>
Cc: Max Staudt <mstaudt@suse.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, michal@markovi.net, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bernhard.rosenkranzer@linaro.org, philm@manjaro.org, hare@suse.de

On Wed, Dec 20, 2017 at 11:22:36AM +0000, Daniel Stone wrote:
> > Also plymouth grabs the escape character of HPE iLOs, which is a serious
> > no-go.
>=20
> I'm not entirely sure what this means, but maybe it's best addressed
> as a bug report to the Plymouth developers? One of them is in this
> thread.

Some server BMCs do have a serial port emulation which can be reached via s=
sh
(apart from IPMI, etc...). HPE's particular implementaion has it's escape
character bound to the Escape key. So with plymouth running, i.e. because y=
our boot
hangs, which for me working on block, scsi and friends happens at least onc=
e a
week results in physically power cycling the machine as I can't exit the
serial emulation and go back to the BMCs shell. I don't care too much as I'm
just a developer and used to power cycle test machines, but I do care about
the customer experience in this case.

To me it looks like the plymouth folks have a slight disconnect from the
server, or non-desktop world. We've already experienced this pattern in the
world of init systems.

Byte,
	Johannes
--=20
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
