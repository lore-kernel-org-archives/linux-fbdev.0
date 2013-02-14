From: Archit Taneja <archit@ti.com>
Date: Thu, 14 Feb 2013 06:52:13 +0000
Subject: Re: [PATCH 16/33] OMAPDSS: acx565akm panel: handle gpios in panel driver
Message-Id: <511C896C.10007@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <1360765345-19312-17-git-send-email-archit@ti.com> <20130213172913.GD21750@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20130213172913.GD21750@blackmetal.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 13 February 2013 10:59 PM, Aaro Koskinen wrote:
> Hi,
>
> On Wed, Feb 13, 2013 at 07:52:08PM +0530, Archit Taneja wrote:
>> +static struct panel_acx565akm_data *get_panel_data(struct omap_dss_device *dssdev)
>> +{
>> +	return (struct panel_acx565akm_data *) dssdev->data;
>> +}
>> +
>>   static int acx_panel_probe(struct omap_dss_device *dssdev)
>>   {
>>   	int r;
>>   	struct acx565akm_device *md = &acx_dev;
>> +	struct panel_acx565akm_data *panel_data = get_panel_data(dssdev);
>
> Why the get_panel_data function is needed, isn't the cast unnecessary?

the 'data' member of omap_dss_device has the type 'void *', we need to 
cast it to access the panel_acx565akm_data struct pointer.

Archit

