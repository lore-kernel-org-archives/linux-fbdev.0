From: Joachim Breuer <jmbreuer@gmx.net>
Subject: Re: Linux 2.4.20-pre6
Date: Wed, 11 Sep 2002 14:49:46 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <m365xcu1w5.fsf@venus.fo.et.local>
References: <Pine.GSO.4.21.0209111252340.27524-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailout07.sul.t-online.com ([194.25.134.83])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17p6wf-0002Kb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Sep 2002 05:50:13 -0700
In-Reply-To: <Pine.GSO.4.21.0209111252340.27524-100000@vervain.sonytel.be> (Geert
 Uytterhoeven's message of "Wed, 11 Sep 2002 12:55:52 +0200 (MEST)")
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Wed, 11 Sep 2002, Adrian Bunk wrote:
>> On Tue, 10 Sep 2002, Marcelo Tosatti wrote:
>> 
>> >...
>> > Geert Uytterhoeven <geert@linux-m68k.org>:
>> >...
>> >   o Wrong fbcon_mac dependency
>> >...
>> 
> [SNIP]
>
> Hmmm... I didn't realize vesafb can use fbcon-mac.
>
> However, it seems to be used if you don't enable any of the fbcon-cfb* modules
> only, since fbcon-cfb* takes precendence.
>
> Do people really use 6x11 fonts with vesafb?

I don't use vesafb (as they (do they still?) tend to interfere with
accelerated X). "But I would if I did."

(Currently typing in an XEmacs on a 1600x1200 21" CRT using 6x13
font. No, I still don't get "enough" on one screen...)


So long,
   Joe

-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"


-------------------------------------------------------
In remembrance
www.osdn.com/911/
