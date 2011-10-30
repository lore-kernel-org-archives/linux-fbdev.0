From: Joshua Kinard <kumba@gentoo.org>
Date: Sun, 30 Oct 2011 20:43:45 +0000
Subject: Re: [PATCH v2] GIO bus support for SGI IP22/28
Message-Id: <4EADB701.9040506@gentoo.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20111020221928.0C2191DA27@solo.franken.de>
In-Reply-To: <20111020221928.0C2191DA27@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org, ralf@linux-mips.org, FlorianSchandinat@gmx.de

On 10/20/2011 18:19, Thomas Bogendoerfer wrote:

> SGI IP22/IP28 machines have GIO busses for adding graphics and other
> extension cards. This patch adds support for GIO driver/device
> handling and converts the newport console driver to a GIO driver.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>


Does this handle any glue logic for add-on NIC cards found for Indy and I2?
 I have a G130 Phobus and a rare ThunderLAN card in my Indy.  The Phobus has
an Altera GIO/PCI glue chip.  Not sure about the ThunderLAN.  Both have
normal driver support in the kernel (Phobus is just a Tulip chip).

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
