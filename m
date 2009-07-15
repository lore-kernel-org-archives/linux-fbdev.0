From: Harald Welte <HaraldWelte@viatech.com>
Subject: Re: [PATCH] viafb: update driver to use both I2C Channels
Date: Wed, 15 Jul 2009 22:17:32 +0200
Message-ID: <20090715201732.GZ11272@prithivi.gnumonks.org>
References: <20090715190158.GA9699@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@lists.laptop.org>
Content-Disposition: inline
In-Reply-To: <20090715190158.GA9699@plexity.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.laptop.org/listinfo/devel>,
	<mailto:devel-request@lists.laptop.org?subject=unsubscribe>
List-Archive: <http://lists.laptop.org/pipermail/devel>
List-Post: <mailto:devel@lists.laptop.org>
List-Help: <mailto:devel-request@lists.laptop.org?subject=help>
List-Subscribe: <http://lists.laptop.org/listinfo/devel>,
	<mailto:devel-request@lists.laptop.org?subject=subscribe>
Sender: devel-bounces@lists.laptop.org
Errors-To: devel-bounces@lists.laptop.org
To: Deepak Saxena <dsaxena@laptop.org>
Cc: JosephChan@via.com.tw, OLPC SW Development List <devel@lists.laptop.org>, ScottFang@viatech.com.cn, linux-fbdev-devel@lists.sourceforge.net

Hi Deepak,

as I have pointed out a couple of times to some OLPC folks (not sure if you
were included), there is a via-viafb-i2c tree in my git tree (http://git.gnumonks.org/cgi-bin/gitweb.cgi?p=linux-2.6-via.git;a=shortlog;h=refs/heads/via-viafb-i2c)
that tries to clean up the i2c mess (after cleaning up a lot of other mess).

I've submitted a long series of those viafb patches some time ago, but somehow
none of them was merged mainline yet :(

Were you aware of this?  If yes, then it means that you're reluctant to merge
the tons of not-yet-mainline cleanup code from my tree, which I could
understand, too.

-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Free and Open Source Software Liaison
