From: "Carlo E. Prelz" <fluido@fluido.as>
Subject: Re: how to change the background's color ?
Date: Sat, 17 Aug 2002 08:22:08 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020817062208.GA1866@casa.fluido.as>
References: <20020817024914.GA1625@debian>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from a205017.upc-a.chello.nl ([62.163.205.17] helo=mail.fluido.as)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17fwyU-00042F-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 16 Aug 2002 23:22:15 -0700
Received: from fluido by mail.fluido.as with local (Exim 4.02)
	id 17fwyO-0000yY-00
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 17 Aug 2002 08:22:08 +0200
Content-Disposition: inline
In-Reply-To: <20020817024914.GA1625@debian>
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
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Devel Mailing List <linux-fbdev-devel@lists.sourceforge.net>

	Subject: [Linux-fbdev-devel] how to change the background's color ?
	Date: sab, ago 17, 2002 at 04:49:14 +0200

Quoting Stephane Wirtel (stephane.wirtel@belgacom.net):

> i would like to change the background's color.

This is not specific to framebuffers. See 

man setterm

or you can send ansi escape codes to your console. You cand find some
info in the Bash-Prompt-HOWTO (that can be found in the standard
locations - probably you have it somewhere). The howto includes this
nifty script for testing all possible colour combinations:

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

#!/bin/bash
#
#   This file echoes a bunch of color codes to the
#   terminal to demonstrate what's available.  Each
#   line is the color code of one foreground color,
#   out of 17 (default + 16 escapes), followed by a
#   test use of that color on all nine background
#   colors (default + 8 escapes).
#

T='gYw'   # The test text

echo -e "\n                 40m     41m     42m     43m\
     44m     45m     46m     47m";

for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
           '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
           '  36m' '1;36m' '  37m' '1;37m';
  do FG=${FGs// /}
  echo -en " $FGs \033[$FG  $T  "
  for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
    do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
  done
  echo;
done
echo

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

It is probably best for you to include the background change escape
sequence in your shell prompt, so your preferred colour is re-set each
time the prompt is displayed (programs like mc and ls (colorized)
change the setting). 

Hope it helps.

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
