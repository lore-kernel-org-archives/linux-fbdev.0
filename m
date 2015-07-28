From: Ilyes Gouta <ilyes.gouta@gmail.com>
Date: Tue, 28 Jul 2015 12:35:27 +0000
Subject: Dynamically setting new modes via framebuffer
Message-Id: <CAL4m05XzdFbMrLcBLxrE_eOg=_rNOryKwvKumKXizU1i_H5VOg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

What's the standard framebuffer (driver) behavior for when a
fbdev-based application is already running (so mode set, framebuffer
alreay mapped) and the user attempts to set a new mode using fbset
(without the first application knowing about it)?

Should the driver deny it and e.g. return -EBUSY? Is the interface
simply permissive about that? Then how could the application get
notifications about mode change and adjust its rendering parameters?

Regards,
Ilyes

P.S: please CC me as I'm not registered with the mailing-list.
