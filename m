From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 09 Mar 2003 14:18:29 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047190664.1510.9.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303061526500.4540-100000@phoenix.infradead.org>	<3E688BDA.80
	 
	80506@winischhofer.net>	<1047045694.1310.6.camel@localhost.localdomain>	<3E6
	 8B895.2080500@winischhof	
	er.net>	<1047067923.1226.26.camel@localhost.localdomain>	<3E69065D.3090706@w
	 
	inischhofer.net>	<1047084988.2388.4.camel@localhost.localdomain>	<1047101983
	 .1231.2.camel@localhost.localdomain> 	<3E69FC34.50703@winischhofer.net>
	<1047160870.1212.73.camel@localhost.localdomain> 
	<3E6AB938.3030003@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ruA6-0003Zz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 08 Mar 2003 22:19:55 -0800
In-Reply-To: <3E6AB938.3030003@winischhofer.net>
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
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: James Simmons <jsimmons@infradead.org>, Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2003-03-09 at 11:47, Thomas Winischhofer wrote:
> 
> > Granted, the patch I submitted was a quickwrite, never meant to be
> > applied but serves only to illustrate.  This is a more proper patch,
> > applied against James latest fbdev.diff.  It simplifies the equation,
> > remove the unnecessary 'if' conditional.  Apply it, don't apply it, I
> > don't care.
> 
> That's not up to me to decide. For me, the only thing that counts is 
> that the console can deal with text areas that are smaller than the 
> screen resolution. Besides, your last sentence was certainly not 
> neccessary. You among friends here.
> 

My apologies if I sounded too harsh, no offense was intended.  I just
meant that your code and mine achieves the same and (hopefully) correct
results  And because the code is in a non-performance critical section,
I don't care whichever is used (except for the var->yres and
info->var.yres issue).  

If the code affects a critical section (blitting, character painting,
etc), of course, that's another story.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
