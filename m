From: Paul Mackerras <paulus@samba.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] Fbdev driver for IBM GXT4500P video
	cards
Date: Fri, 8 Dec 2006 08:50:14 +1100
Message-ID: <17784.35990.297107.498146@cargo.ozlabs.ibm.com>
References: <17766.24132.505274.631108@cargo.ozlabs.ibm.com>
	<4577B0C7.80502@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <4577B0C7.80502@us.ibm.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: "Paul A. Clarke" <pc@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net

Paul A. Clarke writes:

> Any reason to believe this wouldn't work with a GXT6500P as well?  It's almost 
> identical to the GXT4500P except for an added geometry engine.

It should work, as you say, but I haven't tested it.

> I have one, but won't be near it again until mid-January.

Let me know how it goes if/when you get to test it.  At a minimum
you'll need to add the 6500's PCI device ID to the table.

Paul.
