From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 29 Aug 2012 13:40:24 +0000
Subject: Re: [PATCH 4/4] ARM: dts: mxs: add oled support for the cfa-10036
Message-Id: <503E1BC8.8060500@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345711351-16367-1-git-send-email-maxime.ripard@free-electrons.com>
 <1345711351-16367-5-git-send-email-maxime.ripard@free-electrons.com>
 <20120823144541.GL24242@S2101-09.ap.freescale.net>
In-Reply-To: <20120823144541.GL24242@S2101-09.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi,

Le 23/08/2012 16:45, Shawn Guo a =E9crit :
> On Thu, Aug 23, 2012 at 10:42:31AM +0200, Maxime Ripard wrote:
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Cc: Brian Lilly <brian@crystalfontz.com>
>> ---
>>  arch/arm/boot/dts/imx28-cfa10036.dts |   20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
> Looks mostly good, but I have to postpone it until driver part gets
> accepted.

Yes, I totally understand that.

Florian, are you ok with merging the fb driver in the first patch?

> Some minor comments below.

Ok, I'll send an update with the next version of the patchset if there
is comments on the driver, or alone if the driver is merged as is.

Maxime

--=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
