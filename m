From: Sven LUTHER <luther@dpt-info.u-strasbg.fr>
Subject: Re: 2.5 atyfb on Sparc question
Date: Mon, 14 Oct 2002 12:04:38 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021014100438.GA2086@iliana>
References: <61DB42B180EAB34E9D28346C11535A780112FDED@nocmail101.ma.tmpw.net> <Pine.LNX.4.33.0210131307110.5997-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23] helo=mel-rto4.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1811we-0001pB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Oct 2002 02:55:28 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210131307110.5997-100000@maxwell.earthlink.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>, linux-fbdev-devel@lists.sourceforge.net

On Sun, Oct 13, 2002 at 01:08:08PM -0700, James Simmons wrote:
> 
> Sorry I have been going threw alot of chabnges recently. Try my lastest
> tree. I just updated it and I'm nearly done change the api.

BTW, i tried this WE to look at porting the pm3fb driver to the new API,
doing a complete rewrite (well, basically starting again from tridentff,
tdfxfb and skeletonfb, and getting the code as needed from current
pm3fb, which has a lot of unneeded stuff in it). I have not much time
though, so it will go slowly.

I thought i may as well write a little HOWTO or something such on the
way of doing this. Since i have not much fbdev writing experience, maybe
i am a good candidate for writing such a thing.

I wanted, in the first step, to do just a basic unaccelerated fbdev
driver, without mode changes and anything fancy, and once this works,
add things incrementally. I believe this approach will be good for
future fbdev driver writters.

Anyway, now for my question.

skeletonfb says that check_var, set_par, setcolreg, pan_display and
blank functions are optional or not required. Is that true, and in case
i don't want to provide them, whay do i put in the fb_ops structure ?

Later, in the fb_ops structure, only set_par, blank and pan_display are
labeled as optional.

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
