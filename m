From: Oliver Neukum <oliver@neukum.org>
Date: Wed, 20 Jan 2010 21:27:31 +0000
Subject: Re: [PATCH] hid: Logitech G13 driver 0.0.4
Message-Id: <201001202227.31732.oliver@neukum.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201001202047.o0KKlMTr014003@mustang.cs.nmsu.edu>
In-Reply-To: <201001202047.o0KKlMTr014003@mustang.cs.nmsu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>
Cc: linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, pavel@ucw.cz, jayakumar.lkml@gmail.com, linux-fbdev@vger.kernel.org, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, jkosina@suse.cz, dmitry.torokhov@gmail.com

Am Mittwoch, 20. Januar 2010 21:47:22 schrieb Rick L. Vinyard Jr.:
> +static ssize_t g13_name_store(struct device *dev,
> +                             struct device_attribute *attr,
> +                             const char *buf, size_t count)
> +{
> +       struct g13_data *data = dev_get_drvdata(dev);
> +       size_t limit = count;
> +       char *end;
> +
> +       spin_lock(&data->lock);
> +
> +       if (data->name != NULL) {
> +               kfree(data->name);
> +               data->name = NULL;
> +       }
> +
> +       end = strpbrk(buf, "\n\r");
> +       if (end != NULL)
> +               limit = end - buf;
> +
> +       if (end != buf) {
> +
> +               if (limit > 100)
> +                       limit = 100;
> +
> +               data->name = kzalloc(limit+1, GFP_KERNEL);

While you hold a spinlock, memory allocations must be done with GFP_ATOMIC.

	Regards
		Oliver
