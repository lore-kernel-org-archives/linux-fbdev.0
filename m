From: Antonino Daplas <adaplas@pol.net>
Subject: Re: newbie question
Date: 10 Mar 2003 10:06:40 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047261892.1266.26.camel@localhost.localdomain>
References: <20030309172143.7419.qmail@web40502.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18sCix-0003lq-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 09 Mar 2003 18:09:07 -0800
In-Reply-To: <20030309172143.7419.qmail@web40502.mail.yahoo.com>
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
To: ayachi gherissi <ayachi19@yahoo.ca>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2003-03-10 at 01:21, ayachi gherissi wrote:
> 
> hi  i'm newbie in framebuffer driver development
> 
> i have a graphics card siliconmotion 721 (Lynx3DM) i want to make the framebuffer driver i get the spec of the card
> 
> i take cyber2000fb driver and i start modifying it
> 
> 
> i activate pci burst 
>     enable linear memory
>     get memory size
>     calculate vclck
>     calculate mclck  
> 
> i know that each hardware is specfic
> my question is
> what other general steps related to hardware
> must i done to get things work
> 

You also need to modify the registers that determines the video mode
(ie, 1024x768 at 85 Hz), the type of colorspace (RGB, 8, 16, 24, 32
bit/pseudocolor, truecolor, directcolor etc), and the hardware color
look-up table (if using pseudocolor, directcolor).

Tony




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
