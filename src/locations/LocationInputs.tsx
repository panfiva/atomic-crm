import {
    Divider,
    Stack,
    Typography,
    useMediaQuery,
    useTheme,
} from '@mui/material';
import {
    AutocompleteInput,
    ReferenceInput,
    TextInput,
    required,
    useCreate,
    useGetIdentity,
    useNotify,
} from 'react-admin';

export const LocationInputs = () => {
    const theme = useTheme();
    const isMobile = useMediaQuery(theme.breakpoints.down('md'));

    return (
        <Stack gap={2} p={1}>
            <Stack gap={3} direction={isMobile ? 'column' : 'row'}>
                <Stack gap={4} flex={4}>
                    <LocationCompanyInputs />
                </Stack>
                <Divider
                    orientation={isMobile ? 'horizontal' : 'vertical'}
                    flexItem
                />
                <Stack gap={4} flex={5}>
                    <LocationAddress />
                </Stack>
            </Stack>
        </Stack>
    );
};

const LocationCompanyInputs = () => {
    const [create] = useCreate();
    const { identity } = useGetIdentity();
    const notify = useNotify();
    const handleCreateCompany = async (name?: string) => {
        if (!name) return;
        try {
            const val = await create(
                'companies',
                {
                    data: {
                        name,
                        sales_id: identity?.id,
                        created_at: new Date().toISOString(),
                    },
                },
                { returnPromise: true }
            );
            return val;
        } catch (error) {
            notify('An error occurred while creating the company', {
                type: 'error',
            });
        }
    };
    return (
        <Stack>
            <Typography variant="h6">Location</Typography>
            <TextInput
                source="name"
                validate={required()}
                helperText={false}
                id="location:name" // added to disable autocomplete
                autoComplete="off" // added to disable autocomplete
                label="Location name"
            />
            <ReferenceInput source="company_id" reference="companies">
                <AutocompleteInput
                    optionText="name"
                    onCreate={handleCreateCompany}
                    helperText={false}
                    filterToQuery={(q: string) => {
                        return {
                            'name@ilike': q,
                        };
                    }}
                />
            </ReferenceInput>
        </Stack>
    );
};

const LocationAddress = () => {
    return (
        <Stack>
            <Typography variant="h6">Additional Info</Typography>
            <TextInput
                source="shipping_address"
                id="location:shipping_address" // added to disable autocomplete
                autoComplete="off" // added to disable autocomplete
                helperText={false}
                multiline
                minRows={5}
                maxRows={15}
            />
            <TextInput
                source="notes"
                helperText={false}
                multiline
                minRows={5}
                maxRows={15}
            />
        </Stack>
    );
};
