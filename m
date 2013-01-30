From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 30 Jan 2013 21:49:26 +0000
Subject: Re: [PATCH v5 1/8] video: mmp display subsystem
Message-Id: <20130130134926.c13aed22.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358410985-2594-1-git-send-email-zzhu3@marvell.com>
In-Reply-To: <1358410985-2594-1-git-send-email-zzhu3@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 17 Jan 2013 16:23:05 +0800
Zhou Zhu <zzhu3@marvell.com> wrote:

> Added mmp display subsystem to support Marvell MMP display controllers.
> 
> This subsystem contains 4 parts:
> --fb folder
> --core.c
> --hw folder
> --panel folder
> 
> 1. fb folder contains implementation of fb.
> fb get path and ovly from common interface and operates on these structures.
> 
> 2. core.c provides common interface for a hardware abstraction.
> Major parts of this interface are:
> a) Path: path is a output device connected to a panel or HDMI TV.
> Main operations of the path is set/get timing/output color.
> fb operates output device through path structure.
> b) Ovly: Ovly is a buffer shown on the path.
> Ovly describes frame buffer and its source/destination size, offset, input
> color, buffer address, z-order, and so on.
> Each fb device maps to one ovly.
> 
> 3. hw folder contains implementation of hardware operations defined by core.c.
> It registers paths for fb use.
> 
> 4. panel folder contains implementation of panels.
> It's connected to path. Panel drivers would also regiester panels and linked
> to path when probe.
> 
>
> ...
>
> +#define list_find(_item, _list, _field, _name)\
> +	do {\
> +		int found = 0;\
> +		list_for_each_entry(_item, &_list, node) {\
> +			dev_dbg(_item->dev, "checking %s, target %s",\
> +					_item->_field, _name);\
> +			if (strcmp(_name, _item->_field) = 0) {\
> +				found = 1;\
> +				break;\
> +			} \
> +		} \
> +		if (!found)\
> +			_item = NULL;\
> +	} while (0)

ick.

This could have been implemented as a nice C function, I suspect.

> +/*
> + * panel list is used to pair panel/path when path/panel registered
> + * path list is used for both buffer driver and platdriver
> + * plat driver do path register/unregister
> + * panel driver do panel register/unregister
> + * buffer driver get registered path
> + */
> +static LIST_HEAD(panel_list);
> +static LIST_HEAD(path_list);
> +static DEFINE_MUTEX(disp_lock);
> +
> +int mmp_register_panel(struct mmp_panel *panel)
> +{
> +	struct mmp_path *path;
> +
> +	mutex_lock(&disp_lock);
> +
> +	/* add */
> +	list_add_tail(&panel->node, &panel_list);
> +
> +	/* try to register to path */
> +	list_find(path, path_list, name, panel->plat_path_name);
> +	if (path) {
> +		dev_info(panel->dev, "register to path %s\n",
> +				panel->plat_path_name);
> +		path->panel = panel;
> +	}
> +
> +	mutex_unlock(&disp_lock);
> +	return 1;
> +}
> +EXPORT_SYMBOL_GPL(mmp_register_panel);

Should this always return success?

Should it return an error if the registration failed?

This function should return 0 on success or a negative errno on error. 
This is a convention we very commonly use.

If this function really can only return success then let's make it a
void returning function.

> +void mmp_unregister_panel(struct mmp_panel *panel)
> +{
> +	mutex_lock(&disp_lock);
> +	list_del(&panel->node);
> +	mutex_unlock(&disp_lock);
> +}
> +EXPORT_SYMBOL_GPL(mmp_unregister_panel);
> +
> +struct mmp_path *mmp_get_path(const char *name)
> +{
> +	struct mmp_path *path;
> +
> +	mutex_lock(&disp_lock);
> +	list_find(path, path_list, name, name);
> +	mutex_unlock(&disp_lock);
> +
> +	return path;
> +}
> +EXPORT_SYMBOL_GPL(mmp_get_path);
> +
> +struct mmp_path *mmp_register_path(struct mmp_path_info *info)

It's generally desirable to document at least the exported interfaces.

> +{
> +	int i, size;

A more appropriate type for `size' is size_t.

> +	struct mmp_path *path = NULL;
> +	struct mmp_panel *panel;
> +
> +	size = sizeof(struct mmp_path)
> +		+ sizeof(struct mmp_ovly) * info->ovly_num;
> +	path = kzalloc(size, GFP_KERNEL);
> +	if (!path)
> +		goto failed;
> +
> +	/* path set */
> +	path->ovlys = (void *)path + sizeof(struct mmp_path);

A trick we often use is to put a zero-length array at the end of the
struct.  So `struct mmp_path' gets:

		struct mmp_ovly overlays[0];
	}

added to it.  Then you'll find that the mmp_path.ovlys field can just
go away and the code will become shorter and more efficient.

I wish you haven't used "ovly".  The kernel has a strong tradition of
spelling things out in full and avoiding the weird abbreviations.  Just
use "overlay".  The code becomes mroe readable and there's never a
problem remembering the name of the identifiers.

> +	mutex_init(&path->access_ok);
> +	path->dev = info->dev;
> +	path->id = info->id;
> +	path->name = info->name;
> +	path->output_type = info->output_type;
> +	path->ovly_num = info->ovly_num;
> +	path->plat_data = info->plat_data;
> +	path->ops.set_mode = info->set_mode;
>
> ...
>
