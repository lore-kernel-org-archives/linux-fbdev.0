From: Boris Bezlaj <boris@gajba.net>
Subject: Re: vertical stripes under OpenFirmware and offb
Date: Wed, 9 Apr 2003 22:04:57 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030409200457.GB618@gajba.net>
References: <20030328110528.GA2403@gajba.net> <Pine.LNX.4.44.0304022311440.3919-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail.g-kabel.si ([193.189.173.117])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 193Low-0002jQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 09 Apr 2003 13:05:22 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304022311440.3919-100000@phoenix.infradead.org>
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
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, Apr 02, 2003 at 11:12:45PM +0100, James Simmons wrote:
> 
> A IMS card user. Could you try out the imsttfb driver as well. I liek to 
> know how well it works in 2.5.X.
> 
Tried 2.5.67 with fbdev patch..it displays the logo and boot messages till
bottom of the screen(time to scroll the text?), then hangs.

With console on ttyS0, the kernel seems to boot fine..

I didn't include ADB keyboard(compile problem)..could this be a problem
to the console susbystem? (highly unlikely, but i had to ask just in
case :)

BTW, what tool could i use to test the fb itself? (besides the mace :)

-- 

  Boris


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
