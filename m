From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2/7] rivafb/nvidiafb: Enable
	hardware monitoring
Date: Mon, 9 Apr 2007 17:14:19 +0200
Message-ID: <20070409171419.6c2b9ccb@hyperion.delvare>
References: <461A2596.4090609@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HavaG-0007GE-51 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 08:15:08 -0700
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]
	helo=mallaury.nerim.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HavaD-000148-ES
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 08:15:08 -0700
In-Reply-To: <461A2596.4090609@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi Antonino,

On Mon, 09 Apr 2007 19:37:58 +0800, Antonino A. Daplas wrote:
> From: Jean Delvare <khali@linux-fr>
> 
> Let the hardware monitoring drivers probe the second rivafb/nvidiafb
> I2C bus for devices.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr>
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>
> ---
> 
>  drivers/video/nvidia/nv_i2c.c   |   10 ++++++----
>  drivers/video/riva/rivafb-i2c.c |   10 ++++++----
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
> index bcde013..2674259 100644
> --- a/drivers/video/nvidia/nv_i2c.c
> +++ b/drivers/video/nvidia/nv_i2c.c
> @@ -86,13 +86,15 @@ static int nvidia_gpio_getsda(void *data
>  	return val;
>  }
>  
> -static int nvidia_setup_i2c_bus(struct nvidia_i2c_chan *chan, const char *name)
> +static int nvidia_setup_i2c_bus(struct nvidia_i2c_chan *chan, const char *name,
> +				unsigned int i2c_class)
>  {
>  	int rc;
>  
>  	strcpy(chan->adapter.name, name);
>  	chan->adapter.owner = THIS_MODULE;
>  	chan->adapter.id = I2C_HW_B_NVIDIA;
> +	chan->adapter.class = i2c_class;
>  	chan->adapter.algo_data = &chan->algo;
>  	chan->adapter.dev.parent = &chan->par->pci_dev->dev;
>  	chan->algo.setsda = nvidia_gpio_setsda;
> @@ -132,13 +134,13 @@ void nvidia_create_i2c_busses(struct nvi
>  	par->chan[2].par = par;
>  
>  	par->chan[0].ddc_base = 0x36;
> -	nvidia_setup_i2c_bus(&par->chan[0], "nvidia #0");
> + 	nvidia_setup_i2c_bus(&par->chan[0], "nvidia #0", I2C_CLASS_HWMON);
>  
>  	par->chan[1].ddc_base = 0x3e;
> -	nvidia_setup_i2c_bus(&par->chan[1], "nvidia #1");
> + 	nvidia_setup_i2c_bus(&par->chan[1], "nvidia #0", 1);

Err, this is not correct, and not what my original patch did.

>  
>  	par->chan[2].ddc_base = 0x50;
> -	nvidia_setup_i2c_bus(&par->chan[2], "nvidia #2");
> + 	nvidia_setup_i2c_bus(&par->chan[2], "nvidia #2", 0);
>  }
>  
>  void nvidia_delete_i2c_busses(struct nvidia_par *par)
> diff --git a/drivers/video/riva/rivafb-i2c.c b/drivers/video/riva/rivafb-i2c.c
> index 0405e83..ca9e7e8 100644
> --- a/drivers/video/riva/rivafb-i2c.c
> +++ b/drivers/video/riva/rivafb-i2c.c
> @@ -88,13 +88,15 @@ static int riva_gpio_getsda(void* data)
>  	return val;
>  }
>  
> -static int riva_setup_i2c_bus(struct riva_i2c_chan *chan, const char *name)
> +static int riva_setup_i2c_bus(struct riva_i2c_chan *chan, const char *name,
> +			      unsigned int i2c_class)
>  {
>  	int rc;
>  
>  	strcpy(chan->adapter.name, name);
>  	chan->adapter.owner		= THIS_MODULE;
>  	chan->adapter.id		= I2C_HW_B_RIVA;
> +	chan->adapter.class		= i2c_class;
>  	chan->adapter.algo_data		= &chan->algo;
>  	chan->adapter.dev.parent	= &chan->par->pdev->dev;
>  	chan->algo.setsda		= riva_gpio_setsda;
> @@ -135,9 +137,9 @@ void riva_create_i2c_busses(struct riva_
>  	par->chan[0].ddc_base = 0x3e;
>  	par->chan[1].ddc_base = 0x36;
>  	par->chan[2].ddc_base = 0x50;
> -	riva_setup_i2c_bus(&par->chan[0], "BUS1");
> -	riva_setup_i2c_bus(&par->chan[1], "BUS2");
> -	riva_setup_i2c_bus(&par->chan[2], "BUS3");
> +	riva_setup_i2c_bus(&par->chan[0], "BUS1", 0);
> +	riva_setup_i2c_bus(&par->chan[1], "BUS2", I2C_CLASS_HWMON);
> +	riva_setup_i2c_bus(&par->chan[2], "BUS3", 0);
>  }
>  
>  void riva_delete_i2c_busses(struct riva_par *par)


-- 
Jean Delvare

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
