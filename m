From: David Miller <davem@davemloft.net>
Subject: Re: [Bugme-new] [Bug 8232] New: Creator3D Framebuffer (sparc64) on
 Sbus/UPA workstation
Date: Tue, 27 Mar 2007 01:24:02 -0700 (PDT)
Message-ID: <20070327.012402.101595789.davem@davemloft.net>
References: <4608CDC5.6020202@systella.fr>
	<20070327.010456.26278286.davem@davemloft.net>
	<4608D34D.7000300@systella.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <4608D34D.7000300@systella.fr>
Sender: sparclinux-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: Text/Plain; charset="iso-8859-1"
To: joel.bertrand@systella.fr
Cc: akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, sparclinux@vger.kernel.org

=46rom: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Tue, 27 Mar 2007 10:18:21 +0200

> 	I understand. Please, can you send to me your .config (for SMP=20
> workstation) and your gcc release. I shall investigate difference=20
> between your configuration and mine. If your U2 is stable, maybe a=20
> kernel option can solve the trouble.

Config is at:

       http://vger.kernel.org/~davem/ultra2.config

GCC is 4.1.2 Ubuntu 4.1.2-0ubuntu4 out of current feisty release.
Current debian gcc-4.1.x is likely almost identical.

My machine is very simply configured, onboard HME ethernet,
Creator3D, and a 45GB scsi disk hung off of the onboard ESP
scsi controller.  512MB of ram.

=46WIW my machine was very unstable (it would power off after being
up for more than 4 minutes) until I cleaned all of the dust out of
the inside and reseat all of the RAM and cpus. :-)
-
To unsubscribe from this list: send the line "unsubscribe sparclinux" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
