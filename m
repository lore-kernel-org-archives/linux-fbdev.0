From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: Adding Radeon 9100 support to radeonfb.c
Date: Fri, 7 Mar 2003 17:59:45 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030307165945.GA4878@iliana>
References: <002801c2e4c9$9b076df0$010a6f0a@pasikathlon>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp5.wanadoo.fr ([193.252.22.29] helo=mwinf0203.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rLCM-0008D0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 07 Mar 2003 08:59:54 -0800
Content-Disposition: inline
In-Reply-To: <002801c2e4c9$9b076df0$010a6f0a@pasikathlon>
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
To: pem3v78 <pem3v78@wp.pl>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, Mar 07, 2003 at 05:50:04PM +0100, pem3v78 wrote:
> Has anyone started working on this ?
> 
> Whoever has any documentation on this chip please send it to me.

It is just a rebranded radeon 8500. You could simply look at what
/proc/pci tells you and copy what is done for the 8500.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
