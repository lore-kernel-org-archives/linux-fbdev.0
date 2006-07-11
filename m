From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH]: frame buffer driver for 2700G LCD
 controller
Date: Tue, 11 Jul 2006 21:46:47 +0800
Message-ID: <44B3ABC7.4070100@gmail.com>
References: <44AD2B75.6050302@compulab.co.il> <44ADC4AE.2040903@gmail.com>
	<44B11542.7010402@compulab.co.il> <44B18F68.2080802@gmail.com>
	<44B3954D.4040302@compulab.co.il> <20060711132402.GB1533@aon.at>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0IZi-00051E-Qj for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Jul 2006 06:46:55 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G0IZi-0004Za-Iz
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Jul 2006 06:46:54 -0700
Received: by py-out-1112.google.com with SMTP id c31so4319385pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 11 Jul 2006 06:46:54 -0700 (PDT)
In-Reply-To: <20060711132402.GB1533@aon.at>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Bernhard Fischer <yght@users.sourceforge.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

Bernhard Fischer wrote:
> Could some kind soul do a recursive s/timming/timing/g in
> drivers/video, please? TIA.
> 

> 
> IIRC it was already stated that it is better to only set the .suspend
> and .resume ops depending on CONFIG_PM (see below instead of the #if
> #else #endif stanza here).
>> +#else
>> +#define mbxfb_suspend	NULL
>> +#define mbxfb_resume	NULL
>> +#endif
> 

No, this is preferred. If possible, we want to avoid ifdef's within
functions or structures.

Tony



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
