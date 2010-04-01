From: Oliver Neukum <oliver@neukum.org>
Date: Thu, 01 Apr 2010 16:58:45 +0000
Subject: Re: [PATCH v6 1/8] hid: new driver for PicoLCD device
Message-Id: <201004011858.45859.oliver@neukum.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100324233707.7243b04d@neptune.home> <20100330223224.18fe4f3e@neptune.home> <20100330223350.32044891@neptune.home>
In-Reply-To: <20100330223350.32044891@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bruno =?utf-8?q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Jaya Kumar <jayakumar.lkml@gmail.com>

Am Dienstag, 30. März 2010 22:33:50 schrieb Bruno Prémont:
> +static ssize_t picolcd_operation_mode_store(struct device *dev,
> +               struct device_attribute *attr, const char *buf, size_t count)
> +{
> +       struct picolcd_data *data = dev_get_drvdata(dev);
> +       struct hid_report *report = NULL;
> +       size_t cnt = count;
> +       int timeout = 5000;
> +       unsigned u;
> +       unsigned long flags;
> +
> +       if (cnt >= 3 && strncmp("lcd", buf, 3) = 0) {
> +               if (data->status & PICOLCD_BOOTLOADER)
> +                       report = picolcd_out_report(REPORT_EXIT_FLASHER, data->hdev);
> +               buf += 3;
> +               cnt -= 3;
> +       } else if (cnt >= 10 && strncmp("bootloader", buf, 10) = 0) {
> +               if (!(data->status & PICOLCD_BOOTLOADER))
> +                       report = picolcd_out_report(REPORT_EXIT_KEYBOARD, data->hdev);
> +               buf += 10;
> +               cnt -= 10;
> +       }
> +       if (!report)
> +               return -EINVAL;
> +
> +       while (cnt > 0 && (*buf = ' ' || *buf = '\t')) {
> +               buf++;
> +               cnt--;
> +       }
> +       while (cnt > 0 && (buf[cnt-1] = '\n' || buf[cnt-1] = '\r'))
> +               cnt--;
> +       if (cnt > 0) {
> +               if (sscanf(buf, "%u", &u) != 1)
> +                       return -EINVAL;
> +               if (u > 30000)
> +                       return -EINVAL;
> +               else
> +                       timeout = u;
> +       }
> +
> +       spin_lock_irqsave(&data->lock, flags);
> +       hid_set_field(report->field[0], 0, timeout & 0xff);
> +       hid_set_field(report->field[0], 1, (timeout >> 8) & 0xff);
> +       usbhid_submit_report(data->hdev, report, USB_DIR_OUT);
> +       spin_unlock_irqrestore(&data->lock, flags);
> +       return count;
> +}
> +
> +static DEVICE_ATTR(operation_mode, 0644, picolcd_operation_mode_show,
> +               picolcd_operation_mode_store);

This violates the one file = one attribute rule.
Can you change this interface?

	Regards
		Oliver
