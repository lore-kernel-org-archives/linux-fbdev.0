From: Martin Sieper <m.si@ngi.de>
Subject: Re: Computer with 1GB and radeonfb
Date: Tue, 10 Jun 2003 12:56:13 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <elmo10552425734633724267220@arbeitspferd>
References: <elmo105432563416005480015305@arbeitspferd> <20030531054213.GA7494@middle.of.nowhere> <elmo1054814768183606478160@arbeitspferd> <20030605190406.GA1048@middle.of.nowhere>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mx2.ngi.de ([213.191.74.84])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Pgni-0001JT-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 10 Jun 2003 03:56:26 -0700
Received: from unknown (HELO arbeitspferd) ([213.20.27.3])
          (envelope-sender <m.si@ngi.de>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <linux-fbdev-devel@lists.sourceforge.net>; 10 Jun 2003 10:43:58 -0000
In-Reply-To: <20030605190406.GA1048@middle.of.nowhere>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 5 Jun 2003 21:04:06 +0200, Jurriaan wrote:
> > Now the radeonfb works in 8 bit mode but not perfect. There are pixel-trash 
> > when I scroll up/down. The 16 bit and 32 bit modes works but I have 
> > wrong colors and the same scroll problem. Any idea?
> > 
> Well, if the first tip doesn't work, and there were two, perhaps you'll
> have more luck with the second one.

OK, I think the radeonfb works with my Radeon 9100 but there is still 
one problem. I can't see the cursor in 15,16 and 32 bit mode!? In 8 bit
mode I can see the cursor it's blinking. Is it possible that in the other
modes the cursor is black on black color? Some hints?

 -Martin



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
