From: John Zielinski <grim@undead.cc>
Subject: Re: 2.6 fbcon and 15/16 bpp
Date: Wed, 24 Dec 2003 01:02:37 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FE92BFD.8020104@undead.cc>
References: <1070348676.4311.39.camel@gaston>  <3FCC4018.4020503@undead.cc>	 <1070403757.4300.75.camel@gaston>  <3FCD17D5.4040804@undead.cc>	 <1070410792.21174.83.camel@gaston>  <3FE8CCE3.4010709@undead.cc>	 <1072230310.739.25.camel@gaston>  <3FE90001.3080207@undead.cc>	 <1072236683.739.32.camel@gaston>  <3FE919E1.7050609@undead.cc> <1072242753.820.41.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090400090109070701060609"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZ26h-0006pb-9w
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Dec 2003 22:02:55 -0800
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AZ26g-0007ur-LF
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Dec 2003 22:02:54 -0800
In-Reply-To: <1072242753.820.41.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------090400090109070701060609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:

>Looks fine, I'll do tests here. What's up with the penguin ? (what do
>you mean by "test order" ?)
>  
>
There are two penguin tests and Tux's colors are wrong in test004 but 
not too bad in test009.  But if you run test007 (the directcolor test) 
before test004 by running "fbtest test007 test004" Tux looks ok for the 
most part (has a green outline, looks like the poor fellow got nuked) 
because test007 leaves the palette not quite linear.

A quick analysis looking at fbtest's debug output I noticed that before 
test007 it uses a 555 color map and a 565 color map after test007.  I'm 
look at it in more detail tommorrow.

I've attached a couple of snips from the fbtest debug logs.  The first 
one is test004 only and the second one is test007 followed by test004.

John


--------------090400090109070701060609
Content-Type: text/plain;
 name="debug1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug1"

Running test test004
clut_create_linear(): GRAY 32
fb_set_cmap()
Colormap start = 0 len = 64
   0: R 0000 G 0000 B 0000 A ffff
   1: R 0842 G 0842 B 0842 A 0000
   2: R 1084 G 1084 B 1084 A 0000
   3: R 18c6 G 18c6 B 18c6 A 0000
   4: R 2108 G 2108 B 2108 A 0000
   5: R 294a G 294a B 294a A 0000
   6: R 318c G 318c B 318c A 0000
   7: R 39ce G 39ce B 39ce A 0000
   8: R 4210 G 4210 B 4210 A 0000
   9: R 4a52 G 4a52 B 4a52 A 0000
  10: R 5294 G 5294 B 5294 A 0000
  11: R 5ad6 G 5ad6 B 5ad6 A 0000
  12: R 6318 G 6318 B 6318 A 0000
  13: R 6b5a G 6b5a B 6b5a A 0000
  14: R 739c G 739c B 739c A 0000
  15: R 7bde G 7bde B 7bde A 0000
  16: R 8421 G 8421 B 8421 A 0000
  17: R 8c63 G 8c63 B 8c63 A 0000
  18: R 94a5 G 94a5 B 94a5 A 0000
  19: R 9ce7 G 9ce7 B 9ce7 A 0000
  20: R a529 G a529 B a529 A 0000
  21: R ad6b G ad6b B ad6b A 0000
  22: R b5ad G b5ad B b5ad A 0000
  23: R bdef G bdef B bdef A 0000
  24: R c631 G c631 B c631 A 0000
  25: R ce73 G ce73 B ce73 A 0000
  26: R d6b5 G d6b5 B d6b5 A 0000
  27: R def7 G def7 B def7 A 0000
  28: R e739 G e739 B e739 A 0000
  29: R ef7b G ef7b B ef7b A 0000
  30: R f7bd G f7bd B f7bd A 0000
  31: R ffff G ffff B ffff A 0000
  32: R 0000 G 0000 B 0000 A 0000
  33: R 0000 G 0000 B 0000 A 0000
  34: R 0000 G 0000 B 0000 A 0000
  35: R 0000 G 0000 B 0000 A 0000
  36: R 0000 G 0000 B 0000 A 0000
  37: R 0000 G 0000 B 0000 A 0000
  38: R 0000 G 0000 B 0000 A 0000
  39: R 0000 G 0000 B 0000 A 0000
  40: R 0000 G 0000 B 0000 A 0000
  41: R 0000 G 0000 B 0000 A 0000
  42: R 0000 G 0000 B 0000 A 0000
  43: R 0000 G 0000 B 0000 A 0000
  44: R 0000 G 0000 B 0000 A 0000
  45: R 0000 G 0000 B 0000 A 0000
  46: R 0000 G 0000 B 0000 A 0000
  47: R 0000 G 0000 B 0000 A 0000
  48: R 0000 G 0000 B 0000 A 0000
  49: R 0000 G 0000 B 0000 A 0000
  50: R 0000 G 0000 B 0000 A 0000
  51: R 0000 G 0000 B 0000 A 0000
  52: R 0000 G 0000 B 0000 A 0000
  53: R 0000 G 0000 B 0000 A 0000
  54: R 0000 G 0000 B 0000 A 0000
  55: R 0000 G 0000 B 0000 A 0000
  56: R 0000 G 0000 B 0000 A 0000
  57: R 0000 G 0000 B 0000 A 0000
  58: R 0000 G 0000 B 0000 A 0000
  59: R 0000 G 0000 B 0000 A 0000
  60: R 0000 G 0000 B 0000 A 0000
  61: R 0000 G 0000 B 0000 A 0000
  62: R 0000 G 0000 B 0000 A 0000
  63: R 0000 G 0000 B 0000 A 0000
test004: PASSED

--------------090400090109070701060609
Content-Type: text/plain;
 name="debug2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug2"

test007: PASSED
Running test test004
clut_create_linear(): GRAY 32
fb_set_cmap()
Colormap start = 0 len = 64
   0: R 0000 G 0000 B 0000 A ffff
   1: R 0842 G 0842 B 0842 A 0000
   2: R 1084 G 1084 B 1084 A 0000
   3: R 18c6 G 18c6 B 18c6 A 0000
   4: R 2108 G 2108 B 2108 A 0000
   5: R 294a G 294a B 294a A 0000
   6: R 318c G 318c B 318c A 0000
   7: R 39ce G 39ce B 39ce A 0000
   8: R 4210 G 4210 B 4210 A 0000
   9: R 4a52 G 4a52 B 4a52 A 0000
  10: R 5294 G 5294 B 5294 A 0000
  11: R 5ad6 G 5ad6 B 5ad6 A 0000
  12: R 6318 G 6318 B 6318 A 0000
  13: R 6b5a G 6b5a B 6b5a A 0000
  14: R 739c G 739c B 739c A 0000
  15: R 7bde G 7bde B 7bde A 0000
  16: R 8421 G 8421 B 8421 A 0000
  17: R 8c63 G 8c63 B 8c63 A 0000
  18: R 94a5 G 94a5 B 94a5 A 0000
  19: R 9ce7 G 9ce7 B 9ce7 A 0000
  20: R a529 G a529 B a529 A 0000
  21: R ad6b G ad6b B ad6b A 0000
  22: R b5ad G b5ad B b5ad A 0000
  23: R bdef G bdef B bdef A 0000
  24: R c631 G c631 B c631 A 0000
  25: R ce73 G ce73 B ce73 A 0000
  26: R d6b5 G d6b5 B d6b5 A 0000
  27: R def7 G def7 B def7 A 0000
  28: R e739 G e739 B e739 A 0000
  29: R ef7b G ef7b B ef7b A 0000
  30: R f7bd G f7bd B f7bd A 0000
  31: R ffff G ffff B ffff A 0000
  32: R 0000 G 8208 B 0000 A 0000
  33: R 0000 G 8618 B 0000 A 0000
  34: R 0000 G 8a28 B 0000 A 0000
  35: R 0000 G 8e38 B 0000 A 0000
  36: R 0000 G 9249 B 0000 A 0000
  37: R 0000 G 9659 B 0000 A 0000
  38: R 0000 G 9a69 B 0000 A 0000
  39: R 0000 G 9e79 B 0000 A 0000
  40: R 0000 G a28a B 0000 A 0000
  41: R 0000 G a69a B 0000 A 0000
  42: R 0000 G aaaa B 0000 A 0000
  43: R 0000 G aeba B 0000 A 0000
  44: R 0000 G b2ca B 0000 A 0000
  45: R 0000 G b6db B 0000 A 0000
  46: R 0000 G baeb B 0000 A 0000
  47: R 0000 G befb B 0000 A 0000
  48: R 0000 G c30b B 0000 A 0000
  49: R 0000 G c71c B 0000 A 0000
  50: R 0000 G cb2c B 0000 A 0000
  51: R 0000 G cf3c B 0000 A 0000
  52: R 0000 G d34c B 0000 A 0000
  53: R 0000 G d75d B 0000 A 0000
  54: R 0000 G db6d B 0000 A 0000
  55: R 0000 G df7d B 0000 A 0000
  56: R 0000 G e38d B 0000 A 0000
  57: R 0000 G e79e B 0000 A 0000
  58: R 0000 G ebae B 0000 A 0000
  59: R 0000 G efbe B 0000 A 0000
  60: R 0000 G f3ce B 0000 A 0000
  61: R 0000 G f7df B 0000 A 0000
  62: R 0000 G fbef B 0000 A 0000
  63: R 0000 G ffff B 0000 A 0000
test004: PASSED

--------------090400090109070701060609--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
