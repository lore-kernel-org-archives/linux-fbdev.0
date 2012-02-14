From: Grazvydas Ignotas <notasas@gmail.com>
Date: Tue, 14 Feb 2012 13:14:50 +0000
Subject: Re: [PATCH] OMAP: DSS2: TPO-TD03MTEA1: update default gamma
Message-Id: <CANOLnONLHgRzZ-rez4p9Ou6qCtoWVhZWPXNEgsQarBRVFstTaw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1328573630-7348-1-git-send-email-notasas@gmail.com>
	<1328573630-7348-2-git-send-email-notasas@gmail.com>
	<1329222910.1845.90.camel@deskari>
In-Reply-To: <1329222910.1845.90.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Tue, Feb 14, 2012 at 2:35 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wro=
te:
> Hi,
>
> On Tue, 2012-02-07 at 02:13 +0200, Grazvydas Ignotas wrote:
>> Over time better gamma has been determined and tuned with some
>> equipment so update the defaults. From subjective point of view
>> dark shades should be better visible.
>
> Is there even need for default gamma? I'd guess the panel has a default
> gamma in its firmware, so it should work fine without setting it. And
> there's sysfs interface to set the gamma from userspace.
>
> And, as you said, it's subjective, i.e. there's no right value for it,
> so I'm a bit inclined to say that the driver shouldn't even set a
> default gamma, and just leave it to userspace.

Well for pandora, we encourage people to run custom Linux distros on
the device, people reported running Debian, Arch and Slackware on the
device, so we don't have control over everyone's userspace. To reduce
the need for everyone to hack userspace of their distro of choice, it
would be great to have nice display just from the kernel,
out-of-the-box (this gamma has been tuned with some TV studio
equipment so is not totally subjective). Still if you don't want it,
we can keep carrying that in pandora's kernel tree too.


--=20
Gra=FEvydas
