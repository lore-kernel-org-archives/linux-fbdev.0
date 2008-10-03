From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] matroxfb: Support G200eV chip
Date: Fri, 3 Oct 2008 13:54:11 -0700
Message-ID: <20081003205411.GA7632@tree.beaverton.ibm.com>
References: <20081002092933.2EFC4199B267@f14.poczta.interia.pl>
Reply-To: djwong@us.ibm.com
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754003AbYJCUtA@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081002092933.2EFC4199B267@f14.poczta.interia.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: krzysztof.h1@poczta.fm
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>

On Thu, Oct 02, 2008 at 11:29:33AM +0200, krzysztof.h1@poczta.fm wrote:
> > Support the Matrox G200eV chip, based on timings that I found in the
> > X.org matrox driver.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> > ---
> > 
> 
> Is the new chip requires some changes in handling (e.g. diffrent clock ranges/setting, etc)?
> There is nothing about timings in the patch (aside 230MHz).

As far as I could tell from the corresponding patch to Xorg there aren't
any changes needed... but so far it's only passed the smoke test and the
"it appears to work on my machine" test. :)

--D
