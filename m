From: Russ Dill <russ.dill@gmail.com>
Subject: Re: Backlight support
Date: Tue, 30 Nov 2004 15:40:58 -0700
Message-ID: <f9d2a5e1041130144074ca5507@mail.gmail.com>
References: <40ED4FAC.70406@ticino.com> <1089274696.4740.3.camel@localhost>
	<41AB2E71.8080809@imc-berlin.de>
	<f9d2a5e104112916252c253a2b@mail.gmail.com>
	<017c01c4d6f9$a34fc010$0f01a8c0@max>
Reply-To: Russ Dill <russ.dill@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Content-Type: text/plain; charset="us-ascii"
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, Steven Scholz <steven.scholz@imc-berlin.de>, linux-arm-kernel@lists.arm.linux.org.uk

> I'm keen to get this sorted out and I agree its an ideal use of sysfs. I'm
> still getting up to speed on sysfs though...
>

The sysfs interface should probably tell you about the backlight too,
like, does it need to be on, or is ambient light enough. Possibly
recommended power modes, standardized power modes, or recommendations
based on ambient light.

-------------------------------------------------------------------
Subscription options: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:       http://www.arm.linux.org.uk/armlinux/mlfaq.php
Etiquette: http://www.arm.linux.org.uk/armlinux/mletiquette.php
