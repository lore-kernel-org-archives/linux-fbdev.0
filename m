From: Nicolas Pitre <nico@cam.org>
Subject: Re: Backlight support
Date: Tue, 30 Nov 2004 11:44:12 -0500 (EST)
Message-ID: <Pine.LNX.4.61.0411301136590.13137@xanadu.home>
References: <40ED4FAC.70406@ticino.com>
	<1089274696.4740.3.camel@localhost><41AB2E71.8080809@imc-berlin.de>
	<f9d2a5e104112916252c253a2b@mail.gmail.com>
	<017c01c4d6f9$a34fc010$0f01a8c0@max>
Mime-Version: 1.0
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <017c01c4d6f9$a34fc010$0f01a8c0@max>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, Russ Dill <russ.dill@gmail.com>, Steven Scholz <steven.scholz@imc-berlin.de>, linux-arm-kernel@lists.arm.linux.org.uk

On Tue, 30 Nov 2004, Richard Purdie wrote:

> I have one implementation question though - should backlight drivers be in
> the arch folder (arch/arm/mach-pxa in my case) or should
> drivers/video/backlights be created? They're all likely to be using
> fb_register_client() so maybe the latter would be preferred?

Try to keep pieces of code sorted on their function first. It is harder 
for a subsystem maintainer to go all over the tree looking for all files 
that a particular change to the subsystem might affect than it is for an 
architecture maintainer to look after files affecting a specific 
architecture.


Nicolas

-------------------------------------------------------------------
Subscription options: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:       http://www.arm.linux.org.uk/armlinux/mlfaq.php
Etiquette: http://www.arm.linux.org.uk/armlinux/mletiquette.php
