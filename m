From: Egmont Koblinger <egmont@uhulinux.hu>
Subject: Re: Linux 2.6.7 (stty rows 50 columns 140 reports : No such device
 or address)
Date: Wed, 16 Jun 2004 23:17:17 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58L0.0406162313450.20508@sziami.cs.bme.hu>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org> 
 <20040616095805.GC14936@gemtek.lt>  <40D0432A.1080006@pobox.com>
 <1087395424.5314.2.camel@swoop.gemtek.lt> <Pine.LNX.4.56.0406161728150.14901@pentafluge.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BahnN-0006Qf-Uu
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 14:18:09 -0700
Received: from sziami.cs.bme.hu ([152.66.242.225])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BahnM-0005Rr-Ti
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 14:18:09 -0700
In-Reply-To: <Pine.LNX.4.56.0406161728150.14901@pentafluge.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jsimmons@pentafluge.infradead.org
Cc: Zilvinas Valinskas <zilvinas@gemtek.lt>, Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, David MacKenzie <djm@gnu.ai.mit.edu>

On Wed, 16 Jun 2004 jsimmons@pentafluge.infradead.org wrote:

Hi,

> +#ifdef TIOCGWINSZ
> +  int size_was_set = 0;
> +  int cols, rows;
     ^^^^^^^^^^^^^^^
These should both be initialized to -1 because...

> -	      set_window_size ((int) integer_arg (argv[k]), -1,
> -			       fd, device_name);
> +	      rows = integer_arg (argv[k]);
> +	      size_was_set = 1;

[...]

> -	      set_window_size (-1, (int) integer_arg (argv[k]),
> -			       fd, device_name);
> +	      cols = integer_arg (argv[k]);
> +	      size_was_set = 1;

...here maybe only one of them is set, but...

> +  if (size_was_set)
> +    {
> +      set_window_size (rows, cols, fd, device_name);

...here both of them are used. Looking at the body of size_was_set()
and the code that was removed from stty it's clear that -1 means don't
change, while 0 means change to 0.



-- 
Egmont


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
