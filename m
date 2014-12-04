From: Gyungoh Yoo <gyungoh@gmail.com>
Date: Thu, 04 Dec 2014 02:04:49 +0000
Subject: Re: [PATCH v10 2/6] backlight: Add support Skyworks SKY81452 backlight driver
Message-Id: <20141204020449.GA2939@jack-ThinkPad-T520>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417590332-4912-1-git-send-email-jack.yoo@skyworksinc.com>
 <1417590332-4912-3-git-send-email-jack.yoo@skyworksinc.com>
 <1417600949.12511.7.camel@linux-0dmf.site>
In-Reply-To: <1417600949.12511.7.camel-AfvqVibwNMkMNNZnWhT/Jw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org, matti.vaittinen-OYasijW0DpE@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, florian.vaussard-p8DiymsW2f8@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, antonynpavlov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hytszk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, jack.yoo-tjhQNA90jdKqndwCJWfcng@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Dec 03, 2014 at 11:02:29AM +0100, Oliver Neukum wrote:
> On Wed, 2014-12-03 at 16:05 +0900, gyungoh@gmail.com wrote:
> > +static ssize_t sky81452_bl_store_enable(struct device *dev,
> > +               struct device_attribute *attr, const char *buf, size_t
> > count)
> > +{
> > +       struct regmap *regmap = bl_get_data(to_backlight_device(dev));
> > +       unsigned long value;
> > +       int ret;
> > +
> > +       ret = kstrtoul(buf, 16, &value);
> > +       if (IS_ERR_VALUE(ret))
> > +               return ret;
> > +
> > +       ret = regmap_update_bits(regmap, SKY81452_REG1, SKY81452_EN,
> > +                                       value << CTZ(SKY81452_EN));
> 
> No range checking for value?

Avaiable range is from 0 to SKY81452_EN.
regmap_update_bits() is masking the value.

> 
> > +       if (IS_ERR_VALUE(ret))
> > +               return ret;
> > +
> > +       return count;
> > +}
> 
> 	Regards
> 		Oliver
> 
> -- 
> Oliver Neukum <oneukum@suse.de>
> 
