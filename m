From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [RFC 2.6.28 1/2] gpiolib: add set/get batch v4
Date: Mon, 19 Jan 2009 09:05:32 +1300
Message-ID: <49738B8C.7020404@bluewatersys.com>
References: <12321862383405-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <12321862383405-git-send-email-jayakumar.lkml@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, Eric Miao <eric.miao@marvell.com>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Geert Uytterhoeven <geert@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

Jaya Kumar wrote:
> Hi friends,
> 

> +
> +	/* BATCH GPIO OUTPUT */
> +int gpio_set_batch(unsigned gpio, u32 values, u32 bitmask, int maskwidth);
> +
> +The following examples help explain how this function is to be used.
> + Q: How to set gpio pins 0 through 7 to all 0? (8 bits)
> + A: gpio_set_batch(gpio=0, values=0x0, bitmask=0xFF, width=8);
> + Q: How to set gpio pins 58 through 73 to all 1? (16 bits)
> + A: gpio_set_batch(gpio=58, values=0xFFFF, bitmask=0xFFFF, width=16);
> + Q: How to set gpio pins 16 through 47 to 0xCAFEC001? (32 bits)
> + A: gpio_set_batch(gpio=16, values=0xCAFEC001, bitmask=0xFFFFFFFF, width=32);
> +

Can the gpio_set_batch function be used to set non-consecutive gpios?
For example:

  gpio_set_batch(0, 0x0, 0x88, 8);

To clear gpios 3 and 7? It looks like the pxa implementation will
support this, but can it be guaranteed for other architectures? If so,
can we put an example in the documentation. If not, can we make it clear
that you shouldn't do this in the documentation. Also , in the latter
case is it necessary to pass the bitmask, since it will just be ((1 <<
bitwidth) - 1)?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

       Ryan Mallon                              Unit 5, Amuri Park
       Phone: +64 3 3779127                     404 Barbadoes St
       Fax:   +64 3 3779135                     PO Box 13 889
       Email: ryan@bluewatersys.com             Christchurch, 8013
       Web:   http://www.bluewatersys.com       New Zealand
       Freecall Australia  1800 148 751         USA 1800 261 2934

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
