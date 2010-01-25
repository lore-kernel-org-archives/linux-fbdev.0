From: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Date: Mon, 25 Jan 2010 16:49:39 +0000
Subject: Re: [PATCH] hid: Logitech G13 driver 0.0.4
Message-Id: <6ecc677422be02ef48fe8a00a34b8bd2.squirrel@intranet.cs.nmsu.edu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201001202047.o0KKlMTr014003@mustang.cs.nmsu.edu>
    <201001202227.31732.oliver@neukum.org>
In-Reply-To: <201001202227.31732.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, jayakumar.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, krzysztof.h1-5tc4TXWwyLM@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

Oliver Neukum wrote:
> Am Mittwoch, 20. Januar 2010 21:47:22 schrieb Rick L. Vinyard Jr.:
>> +static ssize_t g13_name_store(struct device *dev,
>> +                             struct device_attribute *attr,
>> +                             const char *buf, size_t count)
>> +{
>> +       struct g13_data *data = dev_get_drvdata(dev);
>> +       size_t limit = count;
>> +       char *end;
>> +
>> +       spin_lock(&data->lock);
>> +
>> +       if (data->name != NULL) {
>> +               kfree(data->name);
>> +               data->name = NULL;
>> +       }
>> +
>> +       end = strpbrk(buf, "\n\r");
>> +       if (end != NULL)
>> +               limit = end - buf;
>> +
>> +       if (end != buf) {
>> +
>> +               if (limit > 100)
>> +                       limit = 100;
>> +
>> +               data->name = kzalloc(limit+1, GFP_KERNEL);
>
> While you hold a spinlock, memory allocations must be done with
> GFP_ATOMIC.
>

Thanks for catching that one. I'll recheck all the rest of the allocs.



