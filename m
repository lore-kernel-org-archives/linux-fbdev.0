From: Pawel Moll <pawel.moll@arm.com>
Date: Mon, 23 Jun 2014 14:23:45 +0000
Subject: Re: [PATCH v7 1/2] video: ARM CLCD: Add DT support
Message-Id: <1403533425.3804.35.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403018494-10264-1-git-send-email-pawel.moll@arm.com>
 <CAFEAcA-NZiRDDeUc7n+6hxgjG1V3qYXPAwyfSdtyz=ZCcD8kiw@mail.gmail.com>
 <1403531535.3804.11.camel@hornet>
 <20140623141022.GJ32514@n2100.arm.linux.org.uk>
In-Reply-To: <20140623141022.GJ32514@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 2014-06-23 at 15:10 +0100, Russell King - ARM Linux wrote:
> As far as the CLD outputs are concerned, they are standard.  The PLD on
> their outputs routes the CLD bits to the 8-bit red, green and blue
> channels according to the configuration of SYS_CLCD to achieve the
> various colour formats which the CLCD does not natively provide for.
> 
> So, it /is/ a PL110 with an independent external muxer.

Cool, this means that one can still use this property do define which
CLDs are wired to R/G/B-0s and make an informed decision in the driver
based on this (although with a separate compatible value it won't be
really necessary).

Pawel

