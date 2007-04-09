From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 2/7] rivafb/nvidiafb: Enable
	hardware monitoring
Date: Mon, 09 Apr 2007 23:39:13 +0800
Message-ID: <1176133153.6230.6.camel@daplas>
References: <461A2596.4090609@gmail.com>
	<20070409171419.6c2b9ccb@hyperion.delvare>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Havxg-0003NJ-PT for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 08:39:20 -0700
Received: from wx-out-0506.google.com ([66.249.82.224])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Havxg-0002wq-FZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 08:39:20 -0700
Received: by wx-out-0506.google.com with SMTP id i30so2589212wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 09 Apr 2007 08:39:19 -0700 (PDT)
In-Reply-To: <20070409171419.6c2b9ccb@hyperion.delvare>
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
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2007-04-09 at 17:14 +0200, Jean Delvare wrote:
> Hi Antonino,
> 
> On Mon, 09 Apr 2007 19:37:58 +0800, Antonino A. Daplas wrote:
> > From: Jean Delvare <khali@linux-fr>
> > 
> > Let the hardware monitoring drivers probe the second rivafb/nvidiafb
> > I2C bus for devices.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr>
> > Signed-off-by: Antonino Daplas <adaplas@gmail.com>
> > ---
> > 
> >  drivers/video/nvidia/nv_i2c.c   |   10 ++++++----
> >  drivers/video/riva/rivafb-i2c.c |   10 ++++++----
> >  2 files changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
> > index bcde013..2674259 100644
> > --- a/drivers/video/nvidia/nv_i2c.c
> > +++ b/drivers/video/nvidia/nv_i2c.c
> > @@ -86,13 +86,15 @@ static int nvidia_gpio_getsda(void *data
> >  	return val;
> >  }
> >  
> > -static int nvidia_setup_i2c_bus(struct nvidia_i2c_chan *chan, const char *name)
> > +static int nvidia_setup_i2c_bus(struct nvidia_i2c_chan *chan, const char *name,
> > +				unsigned int i2c_class)
> >  {
> >  	int rc;
> >  
> >  	strcpy(chan->adapter.name, name);
> >  	chan->adapter.owner = THIS_MODULE;
> >  	chan->adapter.id = I2C_HW_B_NVIDIA;
> > +	chan->adapter.class = i2c_class;
> >  	chan->adapter.algo_data = &chan->algo;
> >  	chan->adapter.dev.parent = &chan->par->pci_dev->dev;
> >  	chan->algo.setsda = nvidia_gpio_setsda;
> > @@ -132,13 +134,13 @@ void nvidia_create_i2c_busses(struct nvi
> >  	par->chan[2].par = par;
> >  
> >  	par->chan[0].ddc_base = 0x36;
> > -	nvidia_setup_i2c_bus(&par->chan[0], "nvidia #0");
> > + 	nvidia_setup_i2c_bus(&par->chan[0], "nvidia #0", I2C_CLASS_HWMON);
> >  
> >  	par->chan[1].ddc_base = 0x3e;
> > -	nvidia_setup_i2c_bus(&par->chan[1], "nvidia #1");
> > + 	nvidia_setup_i2c_bus(&par->chan[1], "nvidia #0", 1);
> 
> Err, this is not correct, and not what my original patch did.

Oops, yeah, I just made a typo :-(. I will submit a follow-up patch.

Tony


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
