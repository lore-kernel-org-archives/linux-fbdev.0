From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: [PATCH] New Console system BK
Date: Wed, 3 Jul 2002 11:55:53 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207031155190.16404-100000@www.transvirtual.com>
References: <20020703173822.C8934@suse.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020703173822.C8934@suse.de>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Jones <davej@suse.de>
Cc: Skip Ford <skip.ford@verizon.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux console project <linuxconsole-dev@lists.sourceforge.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


>  > Without the patch, I can hold down alt and hit F1, F2, F3, F4, then
>  > release the alt key and I will have switched to each of the VTs.
>  > With this patch, I have to press/release alt for each Fx key.
>
> Strange, that's a reoccurance of a bug that happened many moons ago
> circa 2.5.4-dj or so, which James then subsequently fixed. Seems he
> dropped a bugfix or two..

Ah. I was using the old patches. I will have to find the fix and put it
into the keyboard driver.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf
