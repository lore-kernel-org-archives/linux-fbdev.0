From: Dave Airlie <airlied@gmail.com>
Date: Tue, 13 Jul 2010 23:35:49 +0000
Subject: Re: [PATCH] viafb: Add transitive dependencies via gpiolib
Message-Id: <AANLkTik8N3lo2FtIv6PrNH1ObvpvCeMDaPeUS_cF_Sk4@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279063845.6139.129.camel@localhost>
In-Reply-To: <1279063845.6139.129.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Wed, Jul 14, 2010 at 9:30 AM, Ben Hutchings <ben@decadent.org.uk> wrote:
> FB_VIA now selects GPIOLIB, but that is not available on all
> architectures. =A0Change FB_VIA dependencies to include GPIOLIB
> dependencies.

If you can find a via chipset on anything not x86 I'd be impressed.

Dave.
