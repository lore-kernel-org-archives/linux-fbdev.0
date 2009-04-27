From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [V5] Xilinx : Framebuffer Driver: Add PLB support and
	cleanup DCR
Date: Mon, 27 Apr 2009 22:58:07 +1000
Message-ID: <1240837087.7169.11.camel@pasglop>
References: <20090417205119.3D35660055@mail16-sin.bigfish.com>
	<200904241301.59775.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <200904241301.59775.arnd@arndb.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Suneel <suneelg@xilinx.com>, linuxppc-dev@ozlabs.org, akonovalov@ru.mvista.com, John Linn <john.linn@xilinx.com>

On Fri, 2009-04-24 at 13:01 +0200, Arnd Bergmann wrote:

> I just said in another email thread that we would need a CONFIG_DCR
> option that DCR using drivers should depend on, if it ever happened
> outside of powerpc.
>
> Well, apparently this happened earlier than I expected.

Sadly...

Cheers,
Ben.
