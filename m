From: Eric =?ISO-8859-1?B?QuluYXJk?= <eric@eukrea.com>
Date: Thu, 21 Nov 2013 08:03:15 +0000
Subject: Re: [PATCHv9][ 1/3] Input: tsc2007: Add device tree support.
Message-Id: <20131121090315.298a4a14@e6520eb>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383916659-9988-1-git-send-email-denis@eukrea.com>
 <20131121050544.GE18477@ns203013.ovh.net>
In-Reply-To: <20131121050544.GE18477@ns203013.ovh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Jean Christophe,

Le Thu, 21 Nov 2013 06:05:44 +0100,
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> a =E9crit :
> > +Optional properties:
> > +- gpios: the interrupt gpio the chip is connected to (trough the penir=
q pin).
> nack use interrupt property this a non-sense that we do today to pass irq=
 via
> gpio property the should NEVER known it's a gpio just an irq

read previous email and you will see the GPIO is used to get the signal
level on the pin and not the IRQ.

Eric
