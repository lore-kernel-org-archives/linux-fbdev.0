From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] neofb patches
Date: Fri, 23 Apr 2004 20:15:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040423201536.6aefe7ad.rddunlap@osdl.org>
References: <56202.64.139.3.221.1082702638.squirrel@www.foogod.com>
	<Pine.LNX.4.44.0404232241260.5826-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S261862AbUDXDQa@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0404232241260.5826-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: alex@foogod.com, linux-fbdev-devel@lists.sourceforge.net, geert@linux-m68k.org, linux-kernel@vger.kernel.org

On Sat, 24 Apr 2004 00:00:23 +0100 (BST) James Simmons <jsimmons@infradead.org> wrote:

| 
| > Ok, I've got everything except the blanking patch (which isn't finished
| > anyway) converted to apply cleanly to James' patched driver source. 
| > Everything works fine on my laptop as far as I can tell.  Additional
| > feedback is welcome.
| > 
| > I've put up a web page for the patches.  They can be found at
| > http://www.foogod.com/~alex/neofb/
| 
| Got it. I merged your patches. I also did a few fixes. The code had issues 
| with non byte align images, i.e sparc 12x22 fonts. Now it works. I posted 
| at
| 
| http://phoenix.infradead.org:~/jsimmons/neofb.diff.gz
| 
| This is against the latest kernel.

Hi James,

I think it would help a bit if someone could load
http://phoenix.infradead.org/~jsimmons/ in a web browser
and be able to see a list of files/patches/etc there
instead of having to know an exact file name to grab.

--
~Randy
