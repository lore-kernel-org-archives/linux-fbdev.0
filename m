From: Jani Monoses <jani@iv.ro>
Subject: Re: [PATCH] fbdev updates.
Date: Tue, 2 Jul 2002 13:33:20 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020702133320.0689de45.jani@iv.ro>
References: <Pine.LNX.4.44.0207011041320.23794-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from iv.ro ([194.105.28.94])
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17PKg9-00025o-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 02 Jul 2002 03:14:38 -0700
In-Reply-To: <Pine.LNX.4.44.0207011041320.23794-100000@www.transvirtual.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@transvirtual.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, 1 Jul 2002 10:48:41 -0700 (PDT)
James Simmons <jsimmons@transvirtual.com> wrote:

> P.S
>        Note I removed the old fbgen stuff so some drivers are going to
> break. Well with time running out I need to push ahead. Sorry but I have
> to choose.

That's OK as long as we know that the drivers which are converted are 100% converted
and can be taken as an example.I prefer this approach instead of having to figure out
which incremental step towards the new api conversion was last taken and try to follow it.
So break the drivers and whatever else it takes so more people can confidently go on
and finally port their drivers.

Jani.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
