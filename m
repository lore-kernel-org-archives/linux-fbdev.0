From: Gerhard Mack <gmack@innerfire.net>
Subject: Re: [PATCH] radeonfb: add support for newer cards
Date: Wed, 3 Jan 2007 15:57:21 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701031556370.5730@mtl.rackplans.net>
References: <20070101212551.GA19598@dreamland.darkstar.lan> 
 <20070101214442.GA21950@dreamland.darkstar.lan>  <1167696853.23340.156.camel@localhost.localdomain>
 <68676e00701011638h55264e00g16504b0e3acdad7f@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932095AbXACU5Y@vger.kernel.org>
In-Reply-To: <68676e00701011638h55264e00g16504b0e3acdad7f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luca <kronos.it@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>, Solomon Peachy <pizza@shaftnet.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Tue, 2 Jan 2007, Luca wrote:

> Date: Tue, 2 Jan 2007 01:38:17 +0100
> From: Luca <kronos.it@gmail.com>
> To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Andrew Morton <akpm@osdl.org>, Solomon Peachy <pizza@shaftnet.org>,
>     linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
> Subject: Re: [PATCH] radeonfb: add support for newer cards
> 
> On 1/2/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > On Mon, 2007-01-01 at 22:44 +0100, Luca Tettamanti wrote:
> > > Il Mon, Jan 01, 2007 at 10:25:51PM +0100, Luca Tettamanti ha scritto:
> > > > Hi Ben, Andrew,
> > > > I've rebased 'ATOM BIOS patch' from Solomon Peachy to apply to 2.6.20.
> > > > The patch adds support for newer Radeon cards and is mainly based on
> > > > X.Org code.
> > >
> > > And - for an easier review - this is the diff between
> > > radeonfb-atom-2.6.19-v6a.diff from Solomon and my patch (whitespace-only
> > > changes not included).
> > 
> > Ah good, what I was asking for :-) I'll try to get a new patch combining
> > everything out asap.
> 
> Great, I didn't know you were working on this, I feared that the patch
> had been forgotten.
> I've a X850 (R480) here, feel free to send me any patch for testing.
> 
> Luca

Is there a list of cards this adds support for?  I'm waiting on support 
for the X1600

	Gerhard



--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
