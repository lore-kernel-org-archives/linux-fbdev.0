From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] Add new framebuffer driver for Fujitsu MB862xx GDCs
Date: Tue, 14 Oct 2008 21:04:55 +0400
Message-ID: <20081014170455.GA16338@oksana.dev.rtsoft.ru>
References: <1223997906-19900-1-git-send-email-agust@denx.de>
	<gd2f4s$82f$1@ger.gmane.org>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
Content-Disposition: inline
In-Reply-To: <gd2f4s$82f$1@ger.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>, linux-fbdev-devel@lists.sourceforge.net

On Tue, Oct 14, 2008 at 03:50:52PM +0000, Dmitry Baryshkov wrote:
> Anatolij Gustschin wrote:
> 
> > This patch adds framebuffer driver for Fujitsu Carmine/Coral-P(A)/Lime
> > graphics controllers. Lime GDC support is known to work on PPC440EPx
> > based lwmon5 and MPC8544E based socrates embedded boards, both equipped
> > with Lime GDC. Carmine/Coral-P PCI GDC support is known to work on
> > PPC440EPx based Sequoia board and also on x86 platform.
> > 
> > Signed-off-by: Anatolij Gustschin <agust@denx.de> ---
> > There are some PPC OF bits, so I'm cc'ing linuxppc-dev list.
> 
> I though there is already carminefb driver.

FWIW, I quite like Anatolij's driver: it has PCI and OF bindings, plus
the patch description states that the driver supports Mint controllers
as well, and I have some hardware that actually needs the support for
Mint GDCs. (Today we just configure the GDC in the firmware and linux
use offb.c driver with static setup, w/o ability to change modes e.t.c.)

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
